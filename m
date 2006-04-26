Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWDZORP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWDZORP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWDZORP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:17:15 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:20539
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964788AbWDZORO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:17:14 -0400
Message-Id: <444F9D34.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 26 Apr 2006 16:17:56 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <tigran@veritas.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix x86 microcode driver handling of multiple matching
	revisions
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple updates matching a given CPU are found in the update file, the
action taken by the microcode update driver was inappropriate:

- when lower revision microcode was found before matching or higher revision
  one, the driver would needlessly complain that it would not downgrade the
  CPU
- when microcode matching the currently installed revision was found before
  newer revision code, no update would actually take place

To change this behavior, the driver now concludes about possibly updates and
issues messages only when the entire input was parsed.

Additionally, this adds back (in different places, and conditionalized upon
a new module option) some messages removed by a previous patch.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/kernel/microcode.c
2.6.17-rc2-x86-microcode/arch/i386/kernel/microcode.c
--- /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/kernel/microcode.c	2006-04-26 10:55:11.000000000 +0200
+++ 2.6.17-rc2-x86-microcode/arch/i386/kernel/microcode.c	2006-03-27 22:46:38.000000000 +0200
@@ -91,7 +91,10 @@ MODULE_DESCRIPTION("Intel CPU (IA-32) Mi
 MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
 MODULE_LICENSE("GPL");
 
-#define MICROCODE_VERSION 	"1.14"
+static int verbose;
+module_param(verbose, int, 0644);
+
+#define MICROCODE_VERSION 	"1.14a"
 
 #define DEFAULT_UCODE_DATASIZE 	(2000) 	  /* 2000 bytes */
 #define MC_HEADER_SIZE		(sizeof (microcode_header_t))  	  /* 48 bytes */
@@ -122,14 +125,15 @@ static unsigned int user_buffer_size;	/*
 
 typedef enum mc_error_code {
 	MC_SUCCESS 	= 0,
-	MC_NOTFOUND 	= 1,
-	MC_MARKED 	= 2,
-	MC_ALLOCATED 	= 3,
+	MC_IGNORED 	= 1,
+	MC_NOTFOUND 	= 2,
+	MC_MARKED 	= 3,
+	MC_ALLOCATED 	= 4,
 } mc_error_code_t;
 
 static struct ucode_cpu_info {
 	unsigned int sig;
-	unsigned int pf;
+	unsigned int pf, orig_pf;
 	unsigned int rev;
 	unsigned int cksum;
 	mc_error_code_t err;
@@ -164,6 +168,7 @@ static void collect_cpu_info (void *unus
 			rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
 			uci->pf = 1 << ((val[1] >> 18) & 7);
 		}
+		uci->orig_pf = uci->pf;
 	}
 
 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
@@ -197,21 +202,33 @@ static inline void mark_microcode_update
 	pr_debug("   Checksum 0x%x\n", cksum);
 
 	if (mc_header->rev < uci->rev) {
-		printk(KERN_ERR "microcode: CPU%d not 'upgrading' to earlier revision"
-		       " 0x%x (current=0x%x)\n", cpu_num, mc_header->rev, uci->rev);
-		goto out;
+		if (uci->err == MC_NOTFOUND) {
+			uci->err = MC_IGNORED;
+			uci->cksum = mc_header->rev;
+		} else if (uci->err == MC_IGNORED && uci->cksum < mc_header->rev)
+			uci->cksum = mc_header->rev;
 	} else if (mc_header->rev == uci->rev) {
-		/* notify the caller of success on this cpu */
-		uci->err = MC_SUCCESS;
-		goto out;
+		if (uci->err < MC_MARKED) {
+			/* notify the caller of success on this cpu */
+			uci->err = MC_SUCCESS;
+		}
+	} else if (uci->err != MC_ALLOCATED || mc_header->rev > uci->mc->hdr.rev) {
+		pr_debug("microcode: CPU%d found a matching microcode update with "
+			" revision 0x%x (current=0x%x)\n", cpu_num, mc_header->rev, uci->rev);
+		uci->cksum = cksum;
+		uci->pf = pf; /* keep the original mc pf for cksum calculation */
+		uci->err = MC_MARKED; /* found the match */
+		for_each_online_cpu(cpu_num) {
+			if (ucode_cpu_info[cpu_num].mc == uci->mc) {
+				uci->mc = NULL;
+				break;
+			}
+		}
+		if (uci->mc != NULL) {
+			vfree(uci->mc);
+			uci->mc = NULL;
+		}
 	}
-
-	pr_debug("microcode: CPU%d found a matching microcode update with "
-		" revision 0x%x (current=0x%x)\n", cpu_num, mc_header->rev, uci->rev);
-	uci->cksum = cksum;
-	uci->pf = pf; /* keep the original mc pf for cksum calculation */
-	uci->err = MC_MARKED; /* found the match */
-out:
 	return;
 }
 
@@ -253,10 +270,8 @@ static int find_matching_ucodes (void) 
 
 		for_each_online_cpu(cpu_num) {
 			struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
-			if (uci->err != MC_NOTFOUND) /* already found a match or not an online cpu*/
-				continue;
 
-			if (sigmatch(mc_header.sig, uci->sig, mc_header.pf, uci->pf))
+			if (sigmatch(mc_header.sig, uci->sig, mc_header.pf, uci->orig_pf))
 				mark_microcode_update(cpu_num, &mc_header, mc_header.sig, mc_header.pf,
mc_header.cksum);
 		}
 
@@ -295,9 +310,8 @@ static int find_matching_ucodes (void) 
 				}
 				for_each_online_cpu(cpu_num) {
 					struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
-					if (uci->err != MC_NOTFOUND) /* already found a match or not an online cpu*/
-						continue;
-					if (sigmatch(ext_sig.sig, uci->sig, ext_sig.pf, uci->pf)) {
+
+					if (sigmatch(ext_sig.sig, uci->sig, ext_sig.pf, uci->orig_pf)) {
 						mark_microcode_update(cpu_num, &mc_header, ext_sig.sig, ext_sig.pf,
ext_sig.cksum);
 					}
 				}
@@ -368,6 +382,13 @@ static void do_update_one (void * unused
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
 
 	if (uci->mc == NULL) {
+		if (verbose) {
+			if (uci->err == MC_SUCCESS)
+				printk(KERN_INFO "microcode: CPU%d already at revision 0x%x\n",
+					cpu_num, uci->rev);
+			else
+				printk(KERN_INFO "microcode: No new microcode data for CPU%d\n", cpu_num);
+		}
 		return;
 	}
 
@@ -426,6 +447,9 @@ out_free:
 					ucode_cpu_info[j].mc = NULL;
 			}
 		}
+		if (ucode_cpu_info[i].err == MC_IGNORED && verbose)
+			printk(KERN_WARNING "microcode: CPU%d not 'upgrading' to earlier revision"
+			       " 0x%x (current=0x%x)\n", i, ucode_cpu_info[i].cksum, ucode_cpu_info[i].rev);
 	}
 out:
 	return error;


