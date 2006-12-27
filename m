Return-Path: <linux-kernel-owner+w=401wt.eu-S932669AbWL0MFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbWL0MFM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 07:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbWL0MFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 07:05:12 -0500
Received: from web30506.mail.mud.yahoo.com ([68.142.200.119]:31043 "HELO
	web30506.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932669AbWL0MFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 07:05:11 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Dec 2006 07:05:10 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=jTMPFgVI2X+Iby/c8bc8uXQUVBxIYM6ZA+lceFe9k6DhJKAXPavRmP3IS0dV68skc1yaODD4oOr0Ue4FH7vr6xCH6BlD7av2FS8aS7dAm1nYneN8Pf+TVHPo/ap0h6lIHMuKRP/PcplcwlQQbCMzF1ohmZ37+ZHwPhg4HgLQoTA=;
X-YMail-OSG: uGnTG5UVM1lT2pvFnWrjBQ_.rps6zNSr4CLS1Hfp1LXmh3B2v2yFr1brWcRHyQeiV87un96ScOBTFgQ5wmuXQ5XQQpFrw5lXkCy9jyfaUdFGTP.D62PUSKwk7eg17SyKBDKxh21aF0s-
Date: Wed, 27 Dec 2006 03:58:29 -0800 (PST)
From: Rajesham Gajjela <rajeshamg@yahoo.com>
Subject: limiting node (NUMA) memory 
To: linux-kernel@vger.kernel.org
Cc: rajeshamg@yahoo.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1487583681-1167220709=:76667"
Content-Transfer-Encoding: 8bit
Message-ID: <314707.76667.qm@web30506.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1487583681-1167220709=:76667
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

PS: Please cc me I am not on the list:

On 2.6.7 kernel & x86_64 arch, I am trying to limit
the each node memory. I have 4 CPUs on my system and
therefore 4 nodes will be setup. Total RAM is 8G, and
each node will have 2G mem. But at times, I may want
to limit each node mem to 1G - some thing like:
memnode="1G,1G,2G,2G" on the grub. I have written the 
below patch, which is not working. With this patch, 
the machine keeps on rebooting after initrd stage:


 Booting 'Red Hat Enterprise Linux AS
(2.6.7-aruba_0.0.0.49309)'

kernel /vmlinuz-2.6.7-aruba_0.0.0.49309
root=/dev/system/rootvol console=ttyS0,
9600n8 SPEED=9600 CONSOLE=serial ide=nodma
ramdisk_size=40000 quiet hangcheck_t
imer.hangcheck_reboot=1 memnode="1g,1g,1g,2M" gdb=0
   [Linux-bzImage, setup=0x1400, size=0x1e387c]
initrd /initrd-2.6.7-aruba_0.0.0.49309.img
   [Linux-initrd @ 0x37a38000, 0x5b7016 bytes]

Any pointers on my mistake(s) is appreciated.

Rajesham

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1487583681-1167220709=:76667
Content-Type: text/x-patch; name="my.patch"
Content-Description: 4239088822-my.patch
Content-Disposition: inline; filename="my.patch"

diff -urNp -X kernel-2.6.7-dontdiff kernel-2.6.7-orig/arch/x86_64/kernel/e820.c kernel-2.6.7-modif/arch/x86_64/kernel/e820.c
--- kernel-2.6.7-orig/arch/x86_64/kernel/e820.c
+++ kernel-2.6.7-modif/arch/x86_64/kernel/e820.c
@@ -763,7 +763,7 @@ void __init parse_memopt(char *p, char *
 	 *
 	 * -AK
 			 */
-	end_user_pfn = memparse(p, from) + HIGH_MEMORY;
+	end_user_pfn = memparse(p, from);
 	end_user_pfn >>= PAGE_SHIFT;	
 } 
 
diff -urNp -X kernel-2.6.7-dontdiff kernel-2.6.7-orig/arch/x86_64/kernel/setup.c kernel-2.6.7-modif/arch/x86_64/kernel/setup.c
--- kernel-2.6.7-orig/arch/x86_64/kernel/setup.c
+++ kernel-2.6.7-modif/arch/x86_64/kernel/setup.c
@@ -335,6 +335,10 @@ static __init void parse_cmdline_early (
 			if (ptr) stag_HBAs = memparse(ptr+1, &ptr);
 		}
 
+		if (!memcmp(from, "memnode=", 8)) {
+			parse_memnode(from+8);
+		}
+
 	next_char:
 		c = *(from++);
 		if (!c)
diff -urNp -X kernel-2.6.7-dontdiff kernel-2.6.7-orig/arch/x86_64/mm/k8topology.c kernel-2.6.7-modif/arch/x86_64/mm/k8topology.c
--- kernel-2.6.7-orig/arch/x86_64/mm/k8topology.c
+++ kernel-2.6.7-modif/arch/x86_64/mm/k8topology.c
@@ -41,6 +41,22 @@ static __init int find_northbridge(void)
 	return -1; 	
 }
 
+unsigned long memnode[MAXNODE];
+
+void __init
+parse_memnode(char *str)
+{
+	int i = 0;
+	char *p = str;
+	char *p1;
+
+	++str; /* skip "=" */
+	while (i < 8 && ((p = strsep(&str, ",")) != NULL)) {
+		memnode[i++] = memparse(p, &p1);
+	}
+}
+
+
 int __init k8_scan_nodes(unsigned long start, unsigned long end)
 { 
 	unsigned long prevbase;
@@ -59,6 +75,7 @@ int __init k8_scan_nodes(unsigned long s
 	numnodes =  ((reg >> 4) & 7) + 1; 
 
 	printk(KERN_INFO "Number of nodes %d (%x)\n", numnodes, reg);
+	printk(KERN_INFO "DEBUG0: start=%lu, end=%lu\n", start, end);
 
 	memset(&nodes,0,sizeof(nodes)); 
 	prevbase = 0;
@@ -69,6 +86,10 @@ int __init k8_scan_nodes(unsigned long s
 		limit = read_pci_config(0, nb, 1, 0x44 + i*8);
 
 		nodeid = limit & 7; 
+
+		printk(KERN_INFO "DEBUG1: from pci config space - base=%lu, "
+		    "limit=%lu, nodeid=%d\n", base, limit, nodeid);
+
 		if ((base & 3) == 0) { 
 			if (i < numnodes) 
 				printk("Skipping disabled node %d\n", i); 
@@ -151,11 +172,18 @@ int __init k8_scan_nodes(unsigned long s
 	printk(KERN_INFO "Using node hash shift of %d\n", memnode_shift); 
 
 	for (i = 0; i < MAXNODE; i++) { 
-		if (nodes[i].start != nodes[i].end) { 
-			/* assume 1:1 NODE:CPU */
-			cpu_to_node[i] = i; 
+	    if (nodes[i].start != nodes[i].end) { 
+		/* assume 1:1 NODE:CPU */
+		cpu_to_node[i] = i; 
+
+		if (nodes[i].end - nodes[i].start > memnode[i])
+			nodes[i].end =  memnode[i];
+
+		printk(KERN_INFO "DEBUG3: Node %d, memnode:%lu, start:%llu, "
+		    "end:%llu\n", i, memnode[i], nodes[i].start, nodes[i].end);
+
 		setup_node_bootmem(i, nodes[i].start, nodes[i].end); 
-	} 
+	    } 
 	}
 
 	numa_init_array();
diff -urNp -X kernel-2.6.7-dontdiff kernel-2.6.7-orig/include/asm-x86_64/mmzone.h kernel-2.6.7-modif/include/asm-x86_64/mmzone.h
--- kernel-2.6.7-orig/include/asm-x86_64/mmzone.h
+++ kernel-2.6.7-modif/include/asm-x86_64/mmzone.h
@@ -60,6 +60,7 @@ static inline __attribute__((pure)) int 
 /* AK: !DISCONTIGMEM just forces it to 1. Can't we too? */
 #define pfn_valid(pfn)          ((pfn) < num_physpages)
 
+extern void parse_memnode(char *);
 
 #endif
 #endif

--0-1487583681-1167220709=:76667--
