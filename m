Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313307AbSEVNeH>; Wed, 22 May 2002 09:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSEVNeG>; Wed, 22 May 2002 09:34:06 -0400
Received: from [195.63.194.11] ([195.63.194.11]:42253 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313307AbSEVNeE>; Wed, 22 May 2002 09:34:04 -0400
Message-ID: <3CEB8F74.7050804@evision-ventures.com>
Date: Wed, 22 May 2002 14:30:44 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Padraig Brady <padraig@antefacto.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com> <3CEB5F75.4000009@evision-ventures.com> <3CEB9A1B.9040905@antefacto.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Padraig Brady napisa?:
> Martin Dalecki wrote:
> 
>> Remove support for /dev/port altogether.
> 
> 
> FYI:
> 
> [root@pixelbeat padraig]# find /bin /usr/bin /lib /sbin /usr/sbin 
> /usr/lib -maxdepth 1 -type f -perm +111 | xargs grep -l "/dev/port"
> /sbin/hwclock: util-linux
> /sbin/kbdrate: util-linux
> /bin/watchdog: ;-)

Let's have a closer look.

[root@kozaczek sbin]# rpm -qf /sbin/kbdrate
util-linux-2.11n-12
[root@kozaczek sbin]# rpm -qf /sbin/hwclock
util-linux-2.11n-12
[root@kozaczek sbin]#

/dev/null {} \;util-linux-2.11r]# find ./ -name "*.[ch]" -exec grep \/dev\/port
./po/cat-id-tbl.c:  {"Cannot open /dev/port: %s", 971},
./hwclock/cmos.c:    if ((dev_port_fd = open("/dev/port", O_RDWR)) < 0) {
./hwclock/cmos.c:      fprintf(stderr, _("Cannot open /dev/port: %s"), 
strerror(errsv));
./hwclock/clock-ppc.c: *  code and not via /dev/port (still possible via #undef 
...)."

static int
get_permissions_cmos(void) {
   int rc;

   if (use_dev_port) {
     if ((dev_port_fd = open("/dev/port", O_RDWR)) < 0) {
       int errsv = errno;
       fprintf(stderr, _("Cannot open /dev/port: %s"), strerror(errsv));
       rc = 1;
     } else
       rc = 0;
   } else {
     rc = i386_iopl(3);
     if (rc == -2) {

./hwclock/cmos.c:int use_dev_port = 0;          /* 1 for Jensen */
./hwclock/cmos.c:    use_dev_port = 1;
./hwclock/cmos.c:  if (use_dev_port) {
./hwclock/cmos.c:  if (use_dev_port) {
./hwclock/cmos.c:  if (use_dev_port) {
[root@kozaczek util-linux-2.11r]#


void
set_cmos_access(int Jensen, int funky_toy) {

   /* See whether we're dealing with a Jensen---it has a weird I/O
      system.  DEC was just learning how to build Alpha PCs.  */
   if (Jensen || is_in_cpuinfo("system type", "Jensen")) {
     use_dev_port = 1;
     clock_ctl_addr = 0x170;
     clock_data_addr = 0x171;
     if (debug) printf (_("clockport adjusted to 0x%x\n"), clock_ctl_addr);
   }

You can see from the above that the code in question
is accessing /dev/port only for the Jensen architecture...
which is:

1. Obsolete by a bright margin.

2. Very rare.

3. Should be fixed anyway.

4. Most possibly not correct anylonger.

So both of the above aplications in fact don't access /dev/port
at all at 99.9% of the systems.
Since they belong in to the util-linux category - well
we require even new versions of mount for new kernels.

Still no problem at all.

