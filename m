Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSLBDNi>; Sun, 1 Dec 2002 22:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSLBDNi>; Sun, 1 Dec 2002 22:13:38 -0500
Received: from services.cam.org ([198.73.180.252]:21410 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S264745AbSLBDNg>;
	Sun, 1 Dec 2002 22:13:36 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [ALPHA RELEASE] module-init-tools 0.9-alpha
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Sun, 01 Dec 2002 22:20:57 -0500
References: <20021202021427.C7C412C097@lists.samba.org>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20021202032057.60AB1EC3@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just built and installed 0.9-beta.  First it tried to install into 
/usr/local/sbin which is pretty useless here.  Fix this with --prefix=
and tried again.  This time it put things in /sbin as expected, but did
not rename the old files with a .old suffix.  Should this still happen?
If not, what happened with backwards compat?

TIA
Ed Tomlinson

Rusty Russell wrote:

> In message <Pine.LNX.4.44.0211290812500.830-100000@lap.molina> you write:
>> On Fri, 29 Nov 2002, Rusty Russell wrote:
>> 
>> > 0.9-alpha Version
>> 
>> Your make moveold script didn't take into account that the modutils from
>> RedHat and Keith Owens have lsmod, modprobe, and rmmod as symlinks to
>> insmod.  I worked around that by doing a "cp insmod lsmod", etc.
> 
> It should (Debian does the same thing, and it works here):
> 
> # Don't just move symlinks, reset them to point to xxx.old.
> moveold:
> if [ "`echo $(DESTDIR)$(sbindir) | tr -s / /`" = /sbin ]; then :;    \
> else                                                               \
> echo $@ usually only makes sense when installing into /sbin; \
> exit 1;                                                            \
> fi
> for f in insmod lsmod modprobe rmmod depmod; do                       \
> if [ -L /sbin/$$f ]; then                             \
> ln -sf `readlink /sbin/$$f`.old /sbin/$$f;    \
> fi;                                                   \
> mv /sbin/$$f /sbin/$$f.old;                           \
> done
> 
> What part of this doesn't work for you?
> 
>> I took a stock 2.5.50-bk and added the namei.c patch and the patch to
>> module.h out of the NEWS file.  The RedHat 8.0 bootup scripts did not
>> autoload the pcmcia_core, yenta_socket, ds, orinoco_cs, orinoco, and
>> hermes modules, but I could load them by hand.  Unfortuantely, it still
>> does not allow the ethernet interface to be brought up an configured.
> 
> Argh, 0.9-alpha has a bug: I changed /etc/modprobe.conf to
> /tmp/modprobe.conf for testing and didn't revert it before release
> (you can see it trying to open "/tmp/modprobe.conf" in the strace in
> your next mail).
> 
>> [root@lap root]# modprobe orinoco_cs
>> WARNING: Error inserting hermes
>> (/lib/modules/2.4.18-18.8.0/kernel/drivers/net/wireless/hermes.o):
>> Unknown symbol in module
> 
> Once again, a testing bug: I removed backwards compatibility so I
> could test on my stable machine.
> 
> I've fixed both these in 0.9-beta.  If you would test one more time
> for me, I'd appreciate it.  (Or, simply apply the patch below, which
> turns 0.9-alpha into 0.9-beta).
> 
> Thankyou *very* much for your persistent testing!
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> 
> diff -urN module-init-tools-0.9-alpha/ChangeLog
> module-init-tools-0.9-beta/ChangeLog
> --- module-init-tools-0.9-alpha/ChangeLog     2002-11-29 21:45:25.000000000
> +1100
> +++ module-init-tools-0.9-beta/ChangeLog      2002-11-29 21:49:23.000000000
> +1100 @@ -3,6 +3,8 @@
>    CONFIG_KALLSYMS.
>  o Fixed extra newline in "in use by" message.
>  o Fixed parsing for new-style /proc/modules.
> +o Fixed version parsing code (thanks to Adam Richter's report)
> +o Fixed "running out of filedescriptors" (Adam Richter)
>  o Implemented options in modprobe
>  o Implemented install in modprobe
>  o Implemented options in modules.conf2modprobe.conf
> diff -urN module-init-tools-0.9-alpha/configure
> module-init-tools-0.9-beta/configure
> --- module-init-tools-0.9-alpha/configure     2002-11-29 21:45:49.000000000
> +1100
> +++ module-init-tools-0.9-beta/configure      2002-12-02 13:10:43.000000000
> +1100 @@ -783,7 +783,7 @@
>  
>  PACKAGE=module-init-tools
>  
> -VERSION="0.9-alpha"
> +VERSION="0.9-beta"
>  
>  if test "`cd $srcdir && pwd`" != "`pwd`" && test -f
>  $srcdir/config.status; then
>    { echo "configure: error: source directory already configured; run
>    { "make distclean" there first" 1>&2; exit 1; }
> diff -urN module-init-tools-0.9-alpha/configure.in
> module-init-tools-0.9-beta/configure.in
> --- module-init-tools-0.9-alpha/configure.in  2002-11-29 21:44:19.000000000
> +1100
> +++ module-init-tools-0.9-beta/configure.in   2002-12-02 13:10:29.000000000
> +1100 @@ -2,7 +2,7 @@
>  
>  AC_CANONICAL_SYSTEM
>  
> -AM_INIT_AUTOMAKE(module-init-tools,"0.9-alpha")
> +AM_INIT_AUTOMAKE(module-init-tools,"0.9-beta")
>  
>  AC_PROG_CC
>  
> diff -urN module-init-tools-0.9-alpha/modprobe.c
> module-init-tools-0.9-beta/modprobe.c
> --- module-init-tools-0.9-alpha/modprobe.c    2002-11-29 21:46:47.000000000
> +1100
> +++ module-init-tools-0.9-beta/modprobe.c     2002-12-02 13:10:19.000000000
> +1100 @@ -638,11 +638,7 @@
>  { "syslog", 0, NULL, 's' },
>  { NULL, 0, NULL, 0 } };
>  
> -#if 0
>  #define DEFAULT_CONFIG "/etc/modprobe.conf"
> -#else
> -#define DEFAULT_CONFIG "/tmp/modprobe.conf"
> -#endif
>  
>  int main(int argc, char *argv[])
>  {
> @@ -658,9 +654,7 @@
>  struct module_options *modoptions = NULL;
>  struct module *start;
>  
> -#if 0
>  try_old_version("modprobe", argv);
> -#endif
>  
>  while ((opt = getopt_long(argc, argv, "vVC:o:knqsc", options, NULL)) !=
>  -1){ switch (opt) {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

