Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSHYJHB>; Sun, 25 Aug 2002 05:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSHYJHB>; Sun, 25 Aug 2002 05:07:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58891 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317072AbSHYJHA>; Sun, 25 Aug 2002 05:07:00 -0400
Date: Sun, 25 Aug 2002 10:11:11 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Of hanging menuconfig [cause found]
Message-ID: <20020825101111.A21616@flint.arm.linux.org.uk>
References: <20020824151329.GB735@gallifrey> <20020824212144.B746@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020824212144.B746@linux-m68k.org>; from rz@linux-m68k.org on Sat, Aug 24, 2002 at 09:21:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2002 at 09:21:44PM +0200, Richard Zidlicky wrote:
> look at dmesg and add an
> 	alias binfmt-xxxx off
> to /etc/modules.conf so similar problems get caught properly - unless 
> you want to actually use an emulator for this architecture of course :)

I believe Dave was saying that the scripts try to run lxdialog, which
returns with an error code (to the program that called it.)  This error
code is not checked by the caller, who just tries again.  So the execve()
system call is already correctly failing.

The problem lies in activate_menu in scripts/Menuconfig; it contains a
loop that calls a small script which then calls lxdialog.  It only tests
for a limited range of return codes:

	0 1 2 3 4 5 6 139 255

The important thing here is the missing two codes (from bash's man page):

       If  a  command  is not found, the child process created to
       execute it returns a status of 127.  If a command is found
       but is not executable, the return status is 126.

We currently handle neither; we just loop and try again.

> Looking at exec.c, why isn't the result of request_module() tested?

That doesn't really tell you anything; that tells you something successful
happened.  It doesn't tell you that you now have (say) the a.out binary
format loaded; that's why we rescan the formats list afterwards.

Anyway, here's a patch that should solve the problem.  Dave - thanks for
finding this odd behaviour.

--- orig/scripts/Menuconfig	Tue Mar  5 19:56:45 2002
+++ linux/scripts/Menuconfig	Sun Aug 25 10:08:44 2002
@@ -905,6 +905,26 @@
 			cleanup
 			exit 139
 			;;
+		126|127)
+			stty sane
+			clear
+			cat << EOM
+
+There seems to be a problem with the lxdialog companion utility which is
+built prior to running Menuconfig.  lxdialog could not be found, or could
+not be executed.  This can be caused when lxdialog has been built for a
+different architecture.
+
+You should rebuild lxdialog.  This can be done by moving to the
+/usr/src/linux/scripts/lxdialog directory and issuing the "make clean all"
+command.
+
+If the problem persists, you may email the maintainer <mec@shout.net> or
+post a message to <linux-kernel@vger.kernel.org> for additional assistance. 
+
+EOM
+			cleanup
+			exit 1
 		esac
 	done
 }

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

