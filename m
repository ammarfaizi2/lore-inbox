Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266484AbRGDCPV>; Tue, 3 Jul 2001 22:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266485AbRGDCPL>; Tue, 3 Jul 2001 22:15:11 -0400
Received: from p0043.as-l042.contactel.cz ([194.108.237.43]:32384 "EHLO
	p0043.as-l042.contactel.cz") by vger.kernel.org with ESMTP
	id <S266484AbRGDCOw>; Tue, 3 Jul 2001 22:14:52 -0400
Date: Wed, 4 Jul 2001 03:38:07 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: andrew.grover@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: What are rules for acpi_ex_enter_interpreter?
Message-ID: <20010704033807.A1469@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
  ACPI was reporting no S* states on my machine (ASUS A7V) for some time
and today I finally got some time to debug it. Problem is that during
initialization namespace init calls acpi_walk_namespace without
interpreter lock held - but it is wrong - as you can see from stack
trace, acpi_walk_namespace can call down to acpi_ev_address_space_dispatch,
which can call acpi_ex_exit_interpreter - and this is fatal on unlocked
lock :-(

  This points us to another problem - when acpi is compiled into kernel,
for some reason there is pending signal in thread doing ospm_busmgr and 
ospm_system initialization, so it fails to acquire lock because of
down_interruptible fails... but does not print any message, just no
valid S states are found. When acpi is compiled as module, modprobe
hangs until you hit ^C - then it is converted to previous case - module
says OK, but did nothing in reality.

  I did NOT verified other callers of acpi_walk_namespace... And there
is still some problem left, as although now S5 is listed as available,
poweroff still does nothing instead of poweroff.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

Jul  4 02:03:02 ppc kernel: CPU:    0
Jul  4 02:03:02 ppc kernel: EIP:    0010:[printstate+9/48]
Jul  4 02:03:02 ppc kernel: EFLAGS: 00000202
Jul  4 02:03:02 ppc kernel: eax: 0000000e   ebx: c01680d0   ecx: c020e996   edx: 00000001
Jul  4 02:03:02 ppc kernel: esi: cff75e3c   edi: c1428a4c   ebp: c1428c8c   esp: c140dc34
Jul  4 02:03:02 ppc kernel: ds: 0018   es: 0018   ss: 0018
Jul  4 02:03:02 ppc kernel: Process swapper (pid: 1, stackpage=c140d000)
Jul  4 02:03:02 ppc kernel: Stack: c140dc38 00000018 c016955a c016206c 000fdf00 00000000 00000000 00000000 
Jul  4 02:03:02 ppc kernel:        c1428a4c c140dcd4 c0166438 c1428a4c 00000001 000fdf00 00000000 00000020 
Jul  4 02:03:02 ppc kernel:        c140dcd4 c140e50c c020c5cc c015c8a5 c140e50c c020c685 00000001 c020e320 
Jul  4 02:03:02 ppc kernel: Call Trace: [acpi_ex_exit_interpreter+26/48] [acpi_ev_address_space_dispatch+124/208] [acpi_ex_read_field_datum+120/224] [debug_print+21/160] [function_status_exit+49/64] 
Jul  4 02:03:02 ppc kernel:    [acpi_ex_extract_from_field+123/432] [acpi_ex_common_access_field+56/64] [acpi_ex_access_region_field+36/64] [acpi_ex_read_data_from_field+220/288] [acpi_ex_resolve_node_to_value+411/560] [acpi_ex_resolve_to_value+42/80] 
Jul  4 02:03:02 ppc kernel:    [acpi_ex_resolve_operands+282/768] [acpi_ds_eval_region_operands+56/144] [acpi_ds_exec_end_op+705/752] [acpi_ps_parse_loop+945/1904] [acpi_ut_release_mutex+103/144] [acpi_ut_create_generic_state+63/128] 
Jul  4 02:03:02 ppc kernel:    [acpi_ps_parse_aml+519/640] [acpi_ds_get_region_arguments+222/256] [acpi_ds_exec_begin_op+0/304] [acpi_ds_exec_end_op+0/752] [acpi_ns_init_one_object+91/96] [acpi_ns_walk_namespace+193/288] 
Jul  4 02:03:02 ppc kernel:    [acpi_ns_init_one_object+0/96] [acpi_walk_namespace+85/128] [acpi_ns_init_one_object+0/96] [acpi_ns_initialize_objects+61/80] [acpi_ns_init_one_object+0/96] [acpi_enable_subsystem+149/320] 
Jul  4 02:03:02 ppc kernel:    [acpi_enable_subsystem+188/320] [acpi_init+283/352] [rest_init+0/48] [init+11/320] [rest_init+0/48] [kernel_thread+38/48] 
Jul  4 02:03:02 ppc kernel:    [init+0/320] 
Jul  4 02:03:02 ppc kernel: 
Jul  4 02:03:02 ppc kernel: Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 b5 fe ff ff 83 c4 

diff -urdN linux/drivers/acpi/namespace/nsinit.c linux/drivers/acpi/namespace/nsinit.c
--- linux/drivers/acpi/namespace/nsinit.c	Tue Jul  3 15:58:35 2001
+++ linux/drivers/acpi/namespace/nsinit.c	Wed Jul  4 02:20:49 2001
@@ -27,6 +27,7 @@
 #include "acpi.h"
 #include "acnamesp.h"
 #include "acdispat.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 	 MODULE_NAME         ("nsinit")
@@ -62,10 +63,17 @@
 
 	/* Walk entire namespace from the supplied root */
 
+	status = acpi_ex_enter_interpreter();
+	if (ACPI_FAILURE(status)) {
+		return status;
+	}
+	
 	status = acpi_walk_namespace (ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
 			  ACPI_UINT32_MAX, acpi_ns_init_one_object,
 			  &info, NULL);
 
+	acpi_ex_exit_interpreter();
+	
 	return (AE_OK);
 }
 
