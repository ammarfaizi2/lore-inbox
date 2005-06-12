Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVFLLYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVFLLYV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVFLLWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:22:55 -0400
Received: from aun.it.uu.se ([130.238.12.36]:60132 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261952AbVFLLTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:19:36 -0400
Date: Sun, 12 Jun 2005 13:19:30 +0200 (MEST)
Message-Id: <200506121119.j5CBJUQ9019732@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31 5/9] gcc4: fix x86_64 acpi assembly error
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On x86-64 gcc4 generates a compile-time error in acpi:

{standard input}: Assembler messages:
{standard input}:334: Error: suffix or operands invalid for `pop'
{standard input}:343: Error: suffix or operands invalid for `push'
{standard input}:411: Error: suffix or operands invalid for `pop'
{standard input}:425: Error: suffix or operands invalid for `push'
make[3]: *** [bus.o] Error 1
make[3]: Leaving directory `/tmp/linux-2.4.31/drivers/acpi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/tmp/linux-2.4.31/drivers/acpi'
make[1]: *** [_subdir_acpi] Error 2
make[1]: Leaving directory `/tmp/linux-2.4.31/drivers'
make: *** [_dir_drivers] Error 2

This is because a 32-bit operand is used where x86_64 needs a
64-bit operand, leading to syntax errors in the assembly code.

The fix (backport from 2.6) is to use long for the offending operands.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/acpi/bus.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -rupN linux-2.4.31/drivers/acpi/bus.c linux-2.4.31.gcc4-x86_64-acpi-asm-errors/drivers/acpi/bus.c
--- linux-2.4.31/drivers/acpi/bus.c	2005-01-19 18:00:53.000000000 +0100
+++ linux-2.4.31.gcc4-x86_64-acpi-asm-errors/drivers/acpi/bus.c	2005-06-12 11:45:56.000000000 +0200
@@ -623,7 +623,7 @@ acpi_bus_generate_event (
 	int			data)
 {
 	struct acpi_bus_event	*event = NULL;
-	u32			flags = 0;
+	unsigned long		flags = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_bus_generate_event");
 
@@ -656,7 +656,7 @@ int
 acpi_bus_receive_event (
 	struct acpi_bus_event	*event)
 {
-	u32			flags = 0;
+	unsigned long		flags = 0;
 	struct acpi_bus_event	*entry = NULL;
 
 	DECLARE_WAITQUEUE(wait, current);
