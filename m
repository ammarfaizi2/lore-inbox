Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbQKMXmJ>; Mon, 13 Nov 2000 18:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130250AbQKMXmA>; Mon, 13 Nov 2000 18:42:00 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:41221 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129478AbQKMXlw>;
	Mon, 13 Nov 2000 18:41:52 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Chris Evans <chris@scary.beasts.org>
cc: Roman Drahtmueller <draht@suse.de>, Wichert Akkerman <wichert@cistron.nl>,
        vendor-sec@lst.de, linux-kernel@vger.kernel.org
Subject: Local root exploit with kmod and modutils > 2.1.121
In-Reply-To: Your message of "Mon, 13 Nov 2000 20:23:07 -0000."
             <Pine.LNX.4.21.0011131915240.19775-100000@ferret.lmh.ox.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Nov 2000 10:11:42 +1100
Message-ID: <9458.974157102@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000 20:23:07 +0000 (GMT), 
Chris Evans <chris@scary.beasts.org> wrote:
>Either the kernel or modprobe needs to treat the module name with
>_extreme_ distrust, and I see no evidence of that.

Agreed.  modprobe was not designed to run suid.  Calling modprobe from
request_module has the same effect as running suid.  dev_load() can
take the interface name and pass it to modprobe unchanged and modprobe
does not verify its input, it trusts root/kernel.

>Without this distrust, there is a huge amount of code a malicious user can
>play with. Looking at meta_expand() and split_line() in modprobe, there
>are buffer overflows all over the place (lucky an interface name can only
>be 15 characters!). Worse, user-defined input can be passed to sprawling
>interfaces such as glob() and wordexp().

The buffer overflows are not as bad as they look, most of them are on
malloc strings which have calculated sizes.  There are some strcat
calls that are suspect and I have fixed those in my tree, and replaced
the system() calls with safe equivalents.  But that does not fix the
other problems.

(1) Some user defined input is passed directly through the kernel to
    modprobe running as root.

(2) Current modprobe has no way of telling that it was invoked from the
    kernel instead of by root so it cannot apply different verification
    to its parameters for kmod input.

(3) modprobe applies filename expansion to the user supplied input as
    well as the paths from modules.conf.  The former is tainted, the
    latter is not but they are joined together in modprobe.  This is
    fine for root, terrible for kmod.

The only secure fix I can see is to add SAFEMODE=1 to modprobe's
environment and change exec_modprobe.

static char * envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", "SAFEMODE=1", NULL };

In safemode, modprobe will treat its last argument as a module name,
even if it starts with '-'.  Also in safemode, no filename expansion
will be applied to the module name, filename expansion will still be
applied to paths in /etc/modules.conf.

To cater for older kernels (including 2.2), modprobe will treat an
environment of exactly this, and no more
"HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin"
as requiring safemode.  Why add SAFEMODE at all?  In case we want to
change the environment in future.

Chris Evans raised another point.

(4) Passing user defined input directly through the kernel to modprobe
    does more than expose modprobe to suspect input.  If a user can
    find a program that the kernel trusts and whose input is passed
    straight through then they can load any module.  Controlled loading
    with kernel generated names like net-pf-10, eth0 is fine,
    uncontrolled loading of any module name from user input is not.
    This is a pure kernel problem.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
