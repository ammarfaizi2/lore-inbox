Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129191AbRBYN5K>; Sun, 25 Feb 2001 08:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbRBYN5B>; Sun, 25 Feb 2001 08:57:01 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:65354
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129190AbRBYN4u>; Sun, 25 Feb 2001 08:56:50 -0500
Date: Sun, 25 Feb 2001 14:56:43 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s/isa//g in drivers/scsi/g_NCR5380.c and some cleanup (242)
Message-ID: <20010225145642.B764@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(Does anybody know who the maintainer for this code is?)

The patch below moves drivers/scsi/g_NCR5380.c from using isa_{read,
write, memcpy} to ioremap and the equivalent non-isa functions. It
also fixes an 'unused variable' warning and exchanges check_region for
request_region (and fixes a possible scenario where the checked-for
region was unequal in size to the later requested one).

(An indication of how often this code path is used can be found in
the fact that the previous define of NCR5380_write had its payload
and address mixed up, probably making for wierd results should
the code ever be executed.)

Since I feel a bit wierd after following the #defines around in the
code I would appreciate somebody else eyeballing this.


diff -aur linux-242-ac3-clean/drivers/scsi/g_NCR5380.c linux-242-ac3/drivers/scsi/g_NCR5380.c
--- linux-242-ac3-clean/drivers/scsi/g_NCR5380.c	Sat Feb 24 21:20:21 2001
+++ linux-242-ac3/drivers/scsi/g_NCR5380.c	Sun Feb 25 14:07:57 2001
@@ -144,6 +144,10 @@
     [1] __initdata = {{0,},};
 #endif
 
+#ifdef CONFIG_SCSI_G_NCR5380_MEM
+static void *isa_remap_ptr;
+#endif
+
 #define NO_OVERRIDES (sizeof(overrides) / sizeof(struct override))
 
 /*
@@ -264,7 +268,7 @@
 
 int __init generic_NCR5380_detect(Scsi_Host_Template * tpnt){
     static int current_override = 0;
-    int count, i;
+    int count;
     u_int *ports;
     u_int ncr_53c400a_ports[] = {0x280, 0x290, 0x300, 0x310, 0x330,
     		     		0x340, 0x348, 0x350, 0};
@@ -344,6 +348,7 @@
 
 #ifdef CONFIG_SCSI_G_NCR5380_PORT
 	if (ports) {
+	    int i;
 	    /* wakeup sequence for the NCR53C400A and DTC3181E*/
 
 	    /* Disable the adapter and look for a free io port */
@@ -361,8 +366,8 @@
 	        }
 	    else
 	        for(i=0; ports[i]; i++) {
-	            if ((!check_region(ports[i], 16)) && (inb(ports[i]) == 0xff))
-	                break;
+		    if ((inb(ports[i]) == 0xff) && (request_region(ports[i], NCR5380_region_size, "ncr5380")))
+		        break;
 		}
 	    if (ports[i]) {
 	        outb(0x59, 0x779);
@@ -373,33 +378,25 @@
 	        outb(0x80 | i, 0x379);          /* set io port to be used */
         	outb(0xc0, ports[i] + 9);
 	        if (inb(ports[i] + 9) != 0x80)
-	            continue;
+		    goto err_release;
 	        else
 	            overrides[current_override].NCR5380_map_name=ports[i];
 	    } else
-	        continue;
+	        goto err_release;
 	}
-
-	request_region(overrides[current_override].NCR5380_map_name,
-					NCR5380_region_size, "ncr5380");
 #else
-	if(check_mem_region(overrides[current_override].NCR5380_map_name,
-		NCR5380_region_size))
+	if(!request_mem_region(overrides[current_override].NCR5380_map_name,
+		NCR5380_region_size,  "ncr5380"))
 		continue;
-	request_mem_region(overrides[current_override].NCR5380_map_name,
-					NCR5380_region_size, "ncr5380");
+
+	isa_remap_ptr = ioremap(overrides[current_override].NCR5380_map_name +
+				NCR53C400_mem_base, NCR53C400_register_offset);
+	if (!isa_remap_ptr)
+	    goto err_release_mem;
 #endif
 	instance = scsi_register (tpnt, sizeof(struct NCR5380_hostdata));
 	if(instance == NULL)
-	{
-#ifdef CONFIG_SCSI_G_NCR5380_PORT
-		release_region(overrides[current_override].NCR5380_map_name,
-	                                        NCR5380_region_size);
-#else
-		release_mem_region(overrides[current_override].NCR5380_map_name,
-	                                  	NCR5380_region_size);
-#endif
-	}
+	    goto err_release;
 	
 	instance->NCR5380_instance_name = overrides[current_override].NCR5380_map_name;
 
@@ -434,6 +431,19 @@
 
 	++current_override;
 	++count;
+	continue;
+
+    err_release:
+#ifdef CONFIG_SCSI_G_NCR5380_PORT
+	release_region(overrides[current_override].NCR5380_map_name,
+		       NCR5380_region_size);
+#else
+	iounmap(isa_remap_ptr);
+    err_release_mem:
+	release_mem_region(overrides[current_override].NCR5380_map_name,
+			   NCR5380_region_size);
+#endif
+
     }
     return count;
 }
@@ -453,6 +463,7 @@
     release_region(instance->NCR5380_instance_name, NCR5380_region_size);
 #else
     release_mem_region(instance->NCR5380_instance_name, NCR5380_region_size);
+    iounmap(isa_remap_ptr);
 #endif    
 
     if (instance->irq != IRQ_NONE)
@@ -550,7 +561,7 @@
 	    dst[start+i] = NCR5380_read(C400_HOST_BUFFER);
 #else
 	/* implies CONFIG_SCSI_G_NCR5380_MEM */
-	isa_memcpy_fromio(dst+start,NCR53C400_host_buffer+NCR5380_map_name,128);
+	memcpy_fromio(dst+start, isa_remap_ptr+OFFSET_FROM_REMAPPING, 128);
 #endif
 	start+=128;
 	blocks--;
@@ -571,7 +582,7 @@
 	    dst[start+i] = NCR5380_read(C400_HOST_BUFFER);
 #else
 	/* implies CONFIG_SCSI_G_NCR5380_MEM */
-	isa_memcpy_fromio(dst+start,NCR53C400_host_buffer+NCR5380_map_name,128);
+	memcpy_fromio(dst+start, isa_remap_ptr+OFFSET_FROM_REMAPPING, 128);
 #endif
 	start+=128;
 	blocks--;
@@ -658,7 +669,7 @@
 	    NCR5380_write(C400_HOST_BUFFER, src[start+i]);
 #else
 	/* implies CONFIG_SCSI_G_NCR5380_MEM */
-	isa_memcpy_toio(NCR53C400_host_buffer+NCR5380_map_name,src+start,128);
+	memcpy_toio(isa_remap_ptr+OFFSET_FROM_REMAPPING, src+start, 128);
 #endif
 	start+=128;
 	blocks--;
@@ -678,7 +689,7 @@
 	    NCR5380_write(C400_HOST_BUFFER, src[start+i]);
 #else
 	/* implies CONFIG_SCSI_G_NCR5380_MEM */
-	isa_memcpy_toio(NCR53C400_host_buffer+NCR5380_map_name,src+start,128);
+	memcpy_toio(isa_remap_ptr+OFFSET_FROM_REMAPPING, src+start, 128);
 #endif
 	start+=128;
 	blocks--;
diff -aur linux-242-ac3-clean/drivers/scsi/g_NCR5380.h linux-242-ac3/drivers/scsi/g_NCR5380.h
--- linux-242-ac3-clean/drivers/scsi/g_NCR5380.h	Sun Feb 11 12:04:58 2001
+++ linux-242-ac3/drivers/scsi/g_NCR5380.h	Sun Feb 25 14:33:30 2001
@@ -133,11 +133,12 @@
 
 #define NCR53C400_host_buffer 0x3900
 
-#define NCR5380_region_size 0x3a00
+#define OFFSET_FROM_REMAPPING (NCR53C400_host_buffer - NCR53C400_mem_base)
 
+#define NCR5380_region_size 0x3a00
 
-#define NCR5380_read(reg) isa_readb(NCR5380_map_name + NCR53C400_mem_base + (reg))
-#define NCR5380_write(reg, value) isa_writeb(NCR5380_map_name + NCR53C400_mem_base + (reg), value)
+#define NCR5380_read(reg) readb(isa_remap_ptr+(reg))
+#define NCR5380_write(reg, value) writeb(value, isa_remap_ptr+(reg))
 
 #endif
 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

With Microsoft products, failure is not an option - it's a standard component. 
  -- Anonymous
