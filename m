Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSIXL3X>; Tue, 24 Sep 2002 07:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261647AbSIXL3W>; Tue, 24 Sep 2002 07:29:22 -0400
Received: from [198.149.18.6] ([198.149.18.6]:63893 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261646AbSIXL3U>;
	Tue, 24 Sep 2002 07:29:20 -0400
Date: Tue, 24 Sep 2002 14:48:38 -0400
From: Christoph Hellwig <hch@sgi.com>
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: linux-kernel@vger.kernel.org, bobm@fc.hp.com, phil.el@wanadoo.fr,
       torvalds@transmeta.com
Subject: Re: [PATCH][RFC] oprofile 2.5.38 patch
Message-ID: <20020924144838.A1144@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	John Levon <movement@marcelothewonderpenguin.com>,
	linux-kernel@vger.kernel.org, bobm@fc.hp.com, phil.el@wanadoo.fr,
	torvalds@transmeta.com
References: <20020923222933.GA33523@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020923222933.GA33523@compsoc.man.ac.uk>; from movement@marcelothewonderpenguin.com on Mon, Sep 23, 2002 at 11:29:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 11:29:33PM +0100, John Levon wrote:
> 
> At :
> 
> http://oprofile.sourceforge.net/oprofile-2.5.html

Comments:

+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+   mainmenu_option next_comment
+   comment 'Profiling support'
+   bool 'Profiling support' CONFIG_PROFILING
+   source drivers/oprofile/Config.in
+   endmenu
+fi

The check and the menu should go into drivers/oprofile/Config.in

+OProfile system profiling
+CONFIG_OPROFILE
+  OProfile is a profiling system capable of profiling the
+  whole system, include the kernel, kernel modules, libraries,
+  and applications.
+
+  If unsure, say N.

For 2.5 we don't need/want the 'OProfile system profiling' line.

if [ "$CONFIG_PREEMPT" != "y" ]; then
+   dep_tristate 'OProfile system profiling' CONFIG_OPROFILE
$CONFIG_EXPERIMENTAL $CONFIG_PROFILING
+fi

You already tested for CONFIG_EXPERIMENTAL above..  Also you want
an (EXPERIMENTAL) mark.

Together with the above suggestion drivers/oprofile/Config.in should
look roughly like:

if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
   mainmenu_option next_comment
   comment 'Profiling support'
   bool 'Profiling support (EXPERIMENTAL)' CONFIG_PROFILING
   if [ "$CONFIG_PREEMPT" != "y" -a "$CONFIG_PROFILING" = "y" ]; then
      dep_tristate '  OProfile system profiling (EXPERIMENTAL)' CONFIG_OPROFILE
   fi
   endmenu
fi

OTOH I wonder whether you really want an submenu.  It could as well just
be part of the general settings one.

+obj-$(CONFIG_OPROFILE) += oprofile.o
+ 
+oprofile-objs := oprof.o cpu_buffer.o event_buffer.o \
+                       buffer_sync.o oprofilefs.o \
+                       oprofile_files.o
+ 
+include $(ARCH)/Makefile
+ 
+include $(TOPDIR)/Rules.make

Usually <foo>-objs is below obj-*, but that's just cosmetic.  The Makefile
inclusion seems very wrong to me.  Why do you need it?

Shouldn't drivers/oprofile/i386/ be arch/i386/oprofile??


/**
+ * \file oprofilefs.c
+ * Copyright 2002 the LyX Team
+ * Read the file COPYING
+ *
+ * \author John Levon <levon@movementarian.org>
+ *
+ * Based on fs/binfmt_misc.c
+ *
+ * A simple filesystem for configuration and
+ * access of oprofile.
+ */

Why is this copyright different from the others?

ssize_t fail_write(struct file * file, const char * buf, size_t count, loff_t *
offset)
+{
+       return -EPERM;
+}

Why don't you just set no write method at all?

Maybe oprofilefs wants to become a generic version, it has nothing
oprofile-specific..


#ifndef CONFIG_PROFILING
+
+asmlinkage int sys_lookup_dcookie(unsigned long cookie, char * buf, size_t
len)+{
+       return -ENOSYS;
+}
+ 
+#else

Please use cond_syscall() and compile that file only for CONFIG_PROFILING set.

+       struct dcookie_struct * d_cookie; /* cookie, if any */

Make that conditional on CONFIG_PROFILING?

/* Profile hooks */
+#ifdef CONFIG_PROFILING
+EXPORT_SYMBOL(profile_event_register);
+EXPORT_SYMBOL(profile_event_unregister);
+EXPORT_SYMBOL(dcookie_register);
+EXPORT_SYMBOL(dcookie_unregister);
+EXPORT_SYMBOL(get_dcookie);
+#endif

Put that exports into profile.c?


