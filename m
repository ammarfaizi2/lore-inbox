Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVLDONq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVLDONq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 09:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVLDONq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 09:13:46 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:13583 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932231AbVLDONp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 09:13:45 -0500
Date: Sun, 4 Dec 2005 15:15:33 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Questions on __initdata
Message-Id: <20051204151533.13df37c6.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been reading the heading comment of include/linux/init.h to learn
when and how __initdata can be used. Some of the help text doesn't seem
to match my observations, and some of it confused me and could probably
be made clearer. However, I don't feel completely comfortable with this
topic yet and would welcome comments.

First, the comment goes:

> /* These macros are used to mark some functions or 
>  * initialized data (doesn't apply to uninitialized data)
>  * as `initialization' functions. The kernel can take this
>  * as hint that the function is used only during the initialization
>  * phase and free up used memory resources after

My tests (on i386) seem to suggest that "doesn't apply to uninitialized
data" only holds for non-global variables. Tagging uninitialized global
variables __initdata works, and moves the variables from .bss to .data.
Is it correct? Does it work on all archs? If so, the comment above
needs to be fixed.

Second, there is this sentence at the end of the help text:

>  * Don't forget to initialize data not at file scope, i.e. within a function,
>  * as gcc otherwise puts the data into the bss section and not into the init
>  * section.

It took me quite some time to figure out that this part was solely
referring to *static* local variables. Of course, on second thought it
is obvious, as non-static local variables are allocated on the stack at
runtime, and not part of the binary. But I still believe that the text
could be made clearer by explicitely referring to static local
variables.

I'm also slightly puzzled by the whole concept of __initdata static
local variables. They only seem to make sense if the function itself is
tagged __init. If so, isn't it redundant to tag the data __initdata?

Below is a proposed clarification patch.

As a side question, given that an uninitialized global variable being
tagged __initdata will be moved from .bss to .data, will it become a
truly uninitialized variable? Or will it automatically be initialized
to 0 by the compiler as .bss is?

Thanks.

 include/linux/init.h |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- linux-2.6.15-rc5.orig/include/linux/init.h	2005-10-28 18:24:46.000000000 +0200
+++ linux-2.6.15-rc5/include/linux/init.h	2005-12-04 15:00:24.000000000 +0100
@@ -4,11 +4,10 @@
 #include <linux/config.h>
 #include <linux/compiler.h>
 
-/* These macros are used to mark some functions or 
- * initialized data (doesn't apply to uninitialized data)
- * as `initialization' functions. The kernel can take this
- * as hint that the function is used only during the initialization
- * phase and free up used memory resources after
+/* These macros are used to mark some functions or data
+ * as `initialization' material. The kernel can take this as hint
+ * that the function/data is used only during the initialization
+ * phase and free up used memory resources afterwards.
  *
  * Usage:
  * For functions:
@@ -25,16 +24,22 @@
  *
  * extern int initialize_foobar_device(int, int, int) __init;
  *
- * For initialized data:
+ * For initialized global and static local variables:
  * You should insert __initdata between the variable name and equal
  * sign followed by value, e.g.:
  *
- * static int init_variable __initdata = 0;
+ * static int init_variable __initdata = 42;
  * static char linux_logo[] __initdata = { 0x32, 0x36, ... };
  *
- * Don't forget to initialize data not at file scope, i.e. within a function,
- * as gcc otherwise puts the data into the bss section and not into the init
- * section.
+ * For uninitialized global variables:
+ * You should add __initdata after the variable name, e.g.:
+ *
+ * static int init_variable __initdata;
+ *
+ * Tagging an uninitialized global variable "__initdata" will cause
+ * the compiler to move it from .bss to .data.
+ *
+ * Uninitialized static local variables cannot be made "__initdata".
  * 
  * Also note, that this data cannot be "const".
  */

-- 
Jean Delvare
