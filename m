Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261980AbTCZT0o>; Wed, 26 Mar 2003 14:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbTCZT0o>; Wed, 26 Mar 2003 14:26:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15883 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261988AbTCZTZP>; Wed, 26 Mar 2003 14:25:15 -0500
Date: Wed, 26 Mar 2003 19:36:25 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PULL] (4/9) PCMCIA changes
Message-ID: <20030326193625.F8871@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030326193427.B8871@flint.arm.linux.org.uk> <20030326193511.C8871@flint.arm.linux.org.uk> <20030326193537.D8871@flint.arm.linux.org.uk> <20030326193601.E8871@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030326193601.E8871@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 26, 2003 at 07:36:01PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.889.359.3 -> 1.889.359.4
#	drivers/pcmcia/rsrc_mgr.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/18	rmk@flint.arm.linux.org.uk	1.889.359.4
# [PCMCIA] pcmcia-5: Add locking to resource manager.
# 
# Add an element of locking to the resource manager - don't allow
# the PCMCIA resource lists to be changed while the pcmcia code is
# scanning them.
# --------------------------------------------
#
diff -Nru a/drivers/pcmcia/rsrc_mgr.c b/drivers/pcmcia/rsrc_mgr.c
--- a/drivers/pcmcia/rsrc_mgr.c	Wed Mar 26 19:20:24 2003
+++ b/drivers/pcmcia/rsrc_mgr.c	Wed Mar 26 19:20:24 2003
@@ -85,6 +85,8 @@
 /* IO port resource database */
 static resource_map_t io_db = { 0, 0, &io_db };
 
+static DECLARE_MUTEX(rsrc_sem);
+
 #ifdef CONFIG_ISA
 
 typedef struct irq_info_t {
@@ -403,16 +405,20 @@
     static u_char order[] = { 0xd0, 0xe0, 0xc0, 0xf0 };
     static int hi = 0, lo = 0;
     u_long b, i, ok = 0;
-    
-    if (!probe_mem) return;
+
+    if (!probe_mem)
+	return;
+
+    down(&rsrc_sem);
     /* We do up to four passes through the list */
     if (!force_low) {
 	if (hi++ || (inv_probe(is_valid, do_cksum, mem_db.next, s) > 0))
-	    return;
+	    goto out;
 	printk(KERN_NOTICE "cs: warning: no high memory space "
 	       "available!\n");
     }
-    if (lo++) return;
+    if (lo++)
+	goto out;
     for (m = mem_db.next; m != &mem_db; m = n) {
 	n = m->next;
 	/* Only probe < 1 MB */
@@ -432,6 +438,8 @@
 	    }
 	}
     }
+ out:
+    up(&rsrc_sem);
 }
 
 #else /* CONFIG_ISA */
@@ -442,11 +450,13 @@
     resource_map_t *m;
     static int done = 0;
     
-    if (!probe_mem || done++)
-	return;
-    for (m = mem_db.next; m != &mem_db; m = m->next)
-	if (do_mem_probe(m->base, m->num, is_valid, do_cksum, s))
-	    return;
+    if (probe_mem && done++ == 0) {
+	down(&rsrc_sem);
+	for (m = mem_db.next; m != &mem_db; m = m->next)
+	    if (do_mem_probe(m->base, m->num, is_valid, do_cksum, s))
+		break;
+	up(&rsrc_sem);
+    }
 }
 
 #endif /* CONFIG_ISA */
@@ -469,7 +479,9 @@
 {
     ioaddr_t try;
     resource_map_t *m;
-    
+    int ret = -1;
+
+    down(&rsrc_sem);
     for (m = io_db.next; m != &io_db; m = m->next) {
 	try = (m->base & ~(align-1)) + *base;
 	for (try = (try >= m->base) ? try : try+align;
@@ -477,12 +489,16 @@
 	     try += align) {
 	    if (request_io_resource(try, num, name, s->cap.cb_dev) == 0) {
 		*base = try;
-		return 0;
+		ret = 0;
+		goto out;
 	    }
-	    if (!align) break;
+	    if (!align)
+		break;
 	}
     }
-    return -1;
+ out:
+    up(&rsrc_sem);
+    return ret;
 }
 
 int find_mem_region(u_long *base, u_long num, u_long align,
@@ -490,26 +506,35 @@
 {
     u_long try;
     resource_map_t *m;
+    int ret = -1;
 
+    down(&rsrc_sem);
     while (1) {
 	for (m = mem_db.next; m != &mem_db; m = m->next) {
 	    /* first pass >1MB, second pass <1MB */
-	    if ((force_low != 0) ^ (m->base < 0x100000)) continue;
+	    if ((force_low != 0) ^ (m->base < 0x100000))
+		continue;
+
 	    try = (m->base & ~(align-1)) + *base;
 	    for (try = (try >= m->base) ? try : try+align;
 		 (try >= m->base) && (try+num <= m->base+m->num);
 		 try += align) {
 		if (request_mem_resource(try, num, name, s->cap.cb_dev) == 0) {
 		    *base = try;
-		    return 0;
+		    ret = 0;
+		    goto out;
 		}
-		if (!align) break;
+		if (!align)
+		    break;
 	    }
 	}
-	if (force_low) break;
+	if (force_low)
+	    break;
 	force_low++;
     }
-    return -1;
+ out:
+    up(&rsrc_sem);
+    return ret;
 }
 
 /*======================================================================
@@ -534,53 +559,75 @@
 int try_irq(u_int Attributes, int irq, int specific)
 {
     irq_info_t *info = &irq_table[irq];
+    int ret = 0;
+
+    down(&rsrc_sem);
     if (info->Attributes & RES_ALLOCATED) {
 	switch (Attributes & IRQ_TYPE) {
 	case IRQ_TYPE_EXCLUSIVE:
-	    return CS_IN_USE;
+	    ret = CS_IN_USE;
+	    break;
 	case IRQ_TYPE_TIME:
 	    if ((info->Attributes & RES_IRQ_TYPE)
-		!= RES_IRQ_TYPE_TIME)
-		return CS_IN_USE;
-	    if (Attributes & IRQ_FIRST_SHARED)
-		return CS_BAD_ATTRIBUTE;
+		!= RES_IRQ_TYPE_TIME) {
+		ret = CS_IN_USE;
+		break;
+	    }
+	    if (Attributes & IRQ_FIRST_SHARED) {
+		ret = CS_BAD_ATTRIBUTE;
+		break;
+	    }
 	    info->Attributes |= RES_IRQ_TYPE_TIME | RES_ALLOCATED;
 	    info->time_share++;
 	    break;
 	case IRQ_TYPE_DYNAMIC_SHARING:
 	    if ((info->Attributes & RES_IRQ_TYPE)
-		!= RES_IRQ_TYPE_DYNAMIC)
-		return CS_IN_USE;
-	    if (Attributes & IRQ_FIRST_SHARED)
-		return CS_BAD_ATTRIBUTE;
+		!= RES_IRQ_TYPE_DYNAMIC) {
+		ret = CS_IN_USE;
+		break;
+	    }
+	    if (Attributes & IRQ_FIRST_SHARED) {
+		ret = CS_BAD_ATTRIBUTE;
+		break;
+	    }
 	    info->Attributes |= RES_IRQ_TYPE_DYNAMIC | RES_ALLOCATED;
 	    info->dyn_share++;
 	    break;
 	}
     } else {
-	if ((info->Attributes & RES_RESERVED) && !specific)
-	    return CS_IN_USE;
-	if (check_irq(irq) != 0)
-	    return CS_IN_USE;
+	if ((info->Attributes & RES_RESERVED) && !specific) {
+	    ret = CS_IN_USE;
+	    goto out;
+	}
+	if (check_irq(irq) != 0) {
+	    ret = CS_IN_USE;
+	    goto out;
+	}
 	switch (Attributes & IRQ_TYPE) {
 	case IRQ_TYPE_EXCLUSIVE:
 	    info->Attributes |= RES_ALLOCATED;
 	    break;
 	case IRQ_TYPE_TIME:
-	    if (!(Attributes & IRQ_FIRST_SHARED))
-		return CS_BAD_ATTRIBUTE;
+	    if (!(Attributes & IRQ_FIRST_SHARED)) {
+		ret = CS_BAD_ATTRIBUTE;
+		break;
+	    }
 	    info->Attributes |= RES_IRQ_TYPE_TIME | RES_ALLOCATED;
 	    info->time_share = 1;
 	    break;
 	case IRQ_TYPE_DYNAMIC_SHARING:
-	    if (!(Attributes & IRQ_FIRST_SHARED))
-		return CS_BAD_ATTRIBUTE;
+	    if (!(Attributes & IRQ_FIRST_SHARED)) {
+		ret = CS_BAD_ATTRIBUTE;
+		break;
+	    }
 	    info->Attributes |= RES_IRQ_TYPE_DYNAMIC | RES_ALLOCATED;
 	    info->dyn_share = 1;
 	    break;
 	}
     }
-    return 0;
+ out:
+    up(&rsrc_sem);
+    return ret;
 }
 
 #endif
@@ -594,6 +641,7 @@
     irq_info_t *info;
 
     info = &irq_table[irq];
+    down(&rsrc_sem);
     switch (Attributes & IRQ_TYPE) {
     case IRQ_TYPE_EXCLUSIVE:
 	info->Attributes &= RES_RESERVED;
@@ -609,6 +657,7 @@
 	    info->Attributes &= RES_RESERVED;
 	break;
     }
+    up(&rsrc_sem);
 }
 
 #endif
@@ -631,6 +680,8 @@
 	return CS_BAD_SIZE;
 
     ret = CS_SUCCESS;
+
+    down(&rsrc_sem);
     switch (adj->Action) {
     case ADD_MANAGED_RESOURCE:
 	ret = add_interval(&mem_db, base, num);
@@ -649,6 +700,7 @@
     default:
 	ret = CS_UNSUPPORTED_FUNCTION;
     }
+    up(&rsrc_sem);
     
     return ret;
 }
@@ -657,7 +709,7 @@
 
 static int adjust_io(adjust_t *adj)
 {
-    int base, num;
+    int base, num, ret = CS_SUCCESS;
     
     base = adj->resource.io.BasePort;
     num = adj->resource.io.NumPorts;
@@ -666,10 +718,13 @@
     if ((num <= 0) || (base+num > 0x10000) || (base+num <= base))
 	return CS_BAD_SIZE;
 
+    down(&rsrc_sem);
     switch (adj->Action) {
     case ADD_MANAGED_RESOURCE:
-	if (add_interval(&io_db, base, num) != 0)
-	    return CS_IN_USE;
+	if (add_interval(&io_db, base, num) != 0) {
+	    ret = CS_IN_USE;
+	    break;
+	}
 #ifdef CONFIG_ISA
 	if (probe_io)
 	    do_io_probe(base, num);
@@ -679,17 +734,19 @@
 	sub_interval(&io_db, base, num);
 	break;
     default:
-	return CS_UNSUPPORTED_FUNCTION;
+	ret = CS_UNSUPPORTED_FUNCTION;
 	break;
     }
+    up(&rsrc_sem);
 
-    return CS_SUCCESS;
+    return ret;
 }
 
 /*====================================================================*/
 
 static int adjust_irq(adjust_t *adj)
 {
+    int ret = CS_SUCCESS;
 #ifdef CONFIG_ISA
     int irq;
     irq_info_t *info;
@@ -698,33 +755,41 @@
     if ((irq < 0) || (irq > 15))
 	return CS_BAD_IRQ;
     info = &irq_table[irq];
-    
+
+    down(&rsrc_sem);
     switch (adj->Action) {
     case ADD_MANAGED_RESOURCE:
 	if (info->Attributes & RES_REMOVED)
 	    info->Attributes &= ~(RES_REMOVED|RES_ALLOCATED);
 	else
-	    if (adj->Attributes & RES_ALLOCATED)
-		return CS_IN_USE;
+	    if (adj->Attributes & RES_ALLOCATED) {
+		ret = CS_IN_USE;
+		break;
+	    }
 	if (adj->Attributes & RES_RESERVED)
 	    info->Attributes |= RES_RESERVED;
 	else
 	    info->Attributes &= ~RES_RESERVED;
 	break;
     case REMOVE_MANAGED_RESOURCE:
-	if (info->Attributes & RES_REMOVED)
-	    return 0;
-	if (info->Attributes & RES_ALLOCATED)
-	    return CS_IN_USE;
+	if (info->Attributes & RES_REMOVED) {
+	    ret = 0;
+	    break;
+	}
+	if (info->Attributes & RES_ALLOCATED) {
+	    ret = CS_IN_USE;
+	    break;
+	}
 	info->Attributes |= RES_ALLOCATED|RES_REMOVED;
 	info->Attributes &= ~RES_RESERVED;
 	break;
     default:
-	return CS_UNSUPPORTED_FUNCTION;
+	ret = CS_UNSUPPORTED_FUNCTION;
 	break;
     }
+    up(&rsrc_sem);
 #endif
-    return CS_SUCCESS;
+    return ret;
 }
 
 /*====================================================================*/

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

