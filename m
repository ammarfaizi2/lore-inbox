Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbTK3VxM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 16:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTK3VxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 16:53:12 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:15364 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264405AbTK3VxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 16:53:11 -0500
Subject: about held locks in acpi_psx_execute()
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: acpi-devel@lists.sourceforge.net
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1070229185.2183.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sun, 30 Nov 2003 22:53:05 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

While looking at drivers/acpi/parser/psxface.c,I have noticed that the
acpi_psx_execute(0 function seems to held some structures referrenced
when an error occurs during its execution:


acpi_status
acpi_psx_execute (
        struct acpi_namespace_node      *method_node,
        union acpi_operand_object       **params,
        union acpi_operand_object       **return_obj_desc)
{
...
        if (params) {
                /*
                 * The caller "owns" the parameters, so give each one an
extra
                 * reference
                 */
                for (i = 0; params[i]; i++) {
                        acpi_ut_add_reference (params[i]);
                }
        }

        /*
         * 1) Perform the first pass parse of the method to enter any
         * named objects that it creates into the namespace
         */
        ACPI_DEBUG_PRINT ((ACPI_DB_PARSE,
                "**** Begin Method Parse **** Entry=%p obj=%p\n",
                method_node, obj_desc));

        /* Create and init a Root Node */

        op = acpi_ps_create_scope_op ();
        if (!op) {
                return_ACPI_STATUS (AE_NO_MEMORY);
        }

As you can see, acpi_psx_execute() will hold a lock for each element of
the params[] array if there's an error while invoking
acpi_ps_create_scope_op(), for example.

Is this intentional?
Thanks!

