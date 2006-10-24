Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWJXQml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWJXQml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbWJXQks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:40:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:38103 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030420AbWJXQkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:40:06 -0400
Message-Id: <20061024163818.481906000@arndb.de>
References: <20061024163113.694643000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:31:28 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 15/16] add support for dumping spu info from xmon
Content-Disposition: inline; filename=cell-xmon-spu_info.diff
Cc: Michael Ellerman <michael@ellerman.id.au>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <michael@ellerman.id.au>

This patch adds a command to xmon for dumping information about
spu structs. The command is 'sf' for "spu fields" perhaps, and
takes the spu number as an argument. This is the same value as the
spu->number field, or the "phys-id" value of a context when it is
bound to a physical spu.

We try to catch memory errors as we dump each field, hopefully this
will make the command reasonably robust, but YMMV. If people see a
need we can easily add more fields to the dump in future.

Output looks something like this:

0:mon> sf 0
Dumping spu fields at address c00000001ffd9e80:
  number                  = 0x0
  name                    = spe
  devnode->full_name      = /cpus/PowerPC,BE@0/spes/spe@0
  nid                     = 0x0
  local_store_phys        = 0x20000000000
  local_store             = 0xd0000800801e0000
  ls_size                 = 0x0
  isrc                    = 0x4
  node                    = 0x0
  flags                   = 0x0
  dar                     = 0x0
  dsisr                   = 0x0
  class_0_pending         = 0
  irqs[0]                 = 0x16
  irqs[1]                 = 0x17
  irqs[2]                 = 0x24
  slb_replace             = 0x0
  pid                     = 0
  prio                    = 0
  mm                      = 0x0000000000000000
  ctx                     = 0x0000000000000000
  rq                      = 0x0000000000000000
  timestamp               = 0x0000000000000000
  problem_phys            = 0x20000040000
  problem                 = 0xd000080080220000
  problem->spu_runcntl_RW = 0x0
  problem->spu_status_R   = 0x0
  problem->spu_npc_RW     = 0x0
  priv1                   = 0xd000080080240000
  priv1->mfc_sr1_RW       = 0x33
  priv2                   = 0xd000080080250000


Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

 arch/powerpc/xmon/xmon.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6.orig/arch/powerpc/xmon/xmon.c
+++ linux-2.6/arch/powerpc/xmon/xmon.c
@@ -216,7 +216,8 @@ Commands:\n\
   s	single step\n"
 #ifdef CONFIG_PPC_CELL
 "  ss	stop execution on all spus\n\
-  sr	restore execution on stopped spus\n"
+  sr	restore execution on stopped spus\n\
+  sf #	dump spu fields for spu # (in hex)\n"
 #endif
 "  S	print special registers\n\
   t	print backtrace\n\
@@ -2744,8 +2745,66 @@ static void restart_spus(void)
 	}
 }
 
+#define DUMP_WIDTH	23
+#define DUMP_FIELD(obj, format, field)					\
+do {									\
+	if (setjmp(bus_error_jmp) == 0) {				\
+		catch_memory_errors = 1;				\
+		sync();							\
+		printf("  %-*s = "format"\n", DUMP_WIDTH,		\
+				#field, obj->field);			\
+		sync();							\
+		__delay(200);						\
+	} else {							\
+		catch_memory_errors = 0;				\
+		printf("  %-*s = *** Error reading field.\n",		\
+					DUMP_WIDTH, #field);		\
+	}								\
+	catch_memory_errors = 0;					\
+} while (0)
+
+static void dump_spu_fields(struct spu *spu)
+{
+	printf("Dumping spu fields at address %p:\n", spu);
+
+	DUMP_FIELD(spu, "0x%x", number);
+	DUMP_FIELD(spu, "%s", name);
+	DUMP_FIELD(spu, "%s", devnode->full_name);
+	DUMP_FIELD(spu, "0x%x", nid);
+	DUMP_FIELD(spu, "0x%lx", local_store_phys);
+	DUMP_FIELD(spu, "0x%p", local_store);
+	DUMP_FIELD(spu, "0x%lx", ls_size);
+	DUMP_FIELD(spu, "0x%x", node);
+	DUMP_FIELD(spu, "0x%lx", flags);
+	DUMP_FIELD(spu, "0x%lx", dar);
+	DUMP_FIELD(spu, "0x%lx", dsisr);
+	DUMP_FIELD(spu, "%d", class_0_pending);
+	DUMP_FIELD(spu, "0x%lx", irqs[0]);
+	DUMP_FIELD(spu, "0x%lx", irqs[1]);
+	DUMP_FIELD(spu, "0x%lx", irqs[2]);
+	DUMP_FIELD(spu, "0x%x", slb_replace);
+	DUMP_FIELD(spu, "%d", pid);
+	DUMP_FIELD(spu, "%d", prio);
+	DUMP_FIELD(spu, "0x%p", mm);
+	DUMP_FIELD(spu, "0x%p", ctx);
+	DUMP_FIELD(spu, "0x%p", rq);
+	DUMP_FIELD(spu, "0x%p", timestamp);
+	DUMP_FIELD(spu, "0x%lx", problem_phys);
+	DUMP_FIELD(spu, "0x%p", problem);
+	DUMP_FIELD(spu, "0x%x", problem->spu_runcntl_RW);
+	DUMP_FIELD(spu, "0x%x", problem->spu_status_R);
+	DUMP_FIELD(spu, "0x%x", problem->spu_npc_RW);
+	DUMP_FIELD(spu, "0x%p", priv1);
+
+	if (spu->priv1)
+		DUMP_FIELD(spu, "0x%lx", priv1->mfc_sr1_RW);
+
+	DUMP_FIELD(spu, "0x%p", priv2);
+}
+
 static int do_spu_cmd(void)
 {
+	unsigned long num = 0;
 	int cmd;
 
 	cmd = inchar();
@@ -2756,6 +2815,12 @@ static int do_spu_cmd(void)
 	case 'r':
 		restart_spus();
 		break;
+	case 'f':
+		if (scanhex(&num) && num < XMON_NUM_SPUS && spu_info[num].spu)
+			dump_spu_fields(spu_info[num].spu);
+		else
+			printf("*** Error: invalid spu number\n");
+		break;
 	default:
 		return -1;
 	}

--

