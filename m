Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266577AbRGYFlU>; Wed, 25 Jul 2001 01:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266582AbRGYFlK>; Wed, 25 Jul 2001 01:41:10 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:36314 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S266577AbRGYFlA>; Wed, 25 Jul 2001 01:41:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Frank Akujobi <bulggie@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Newbie problem - installing your own kernel.
Date: Tue, 24 Jul 2001 16:38:38 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010724211726.33706.qmail@web12307.mail.yahoo.com>
In-Reply-To: <20010724211726.33706.qmail@web12307.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <01072416383803.00631@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 17:17, Frank Akujobi wrote:
> Hi all,
> Am a newbie and this is my first post. I just
> installed Redhat7.1 (one I downloaded) and it's
> working well even hooked it up to the internet. I
> checked my /usr/src/ and I don't find a /linux
> directory. I find only one directory... /redhat. It
> there something wrong somewhere, or do I have to
> download a kernel source seperately. Doing uname -r
> shows me that I have 2.4.x.x.
>
> Thanks.
> Frank.

Every time you hear that a new kernel has been released, this means you can 
get it from  http://www.kernel.org/pub/linux/kernel/v2.4/.  For example, 
linux-2.4.7.tar.gz.  There's also a ftp.kernel.org and country specific 
mirrors like ftp.us.kernel.org, check www.kernel.org's home page for more 
info.

To actually USE the sucker, untar it (tar xvzf filename.tgz), and cd into the 
directory it just made.  (xvzf works if you download a file like 
"linux-2.4.7.tar.gz".  If you downloaded "linux-2.4.7.tar.bz2" instead try 
"tar xvjf linux-2.4.7.tar.bz2".  For older versions of tar this might be tvIf 
(capital I).  x=extract, v=verbose, z=gzip (j/I=bzip), f=filename is the next 
argument.  Without f it reads from stdin, I.E. "cat file.tgz | tar xvz" 
should work too...  Type "man tar" if you want to read tar's manual page, 
which strangely enough does NOT include clear examples of how to actually use 
it...)

There should be a README file in the newly untarred directory.  Read it.  
There is also a "Documentation" directory, which should be your first stop if 
you want to understand all this code if you know C and actually want to start 
investigating how the linux kernel actually works.  It also has files that 
explain things like what all that stuff in the "proc" directory an an 
installed system is, or what config files you have to tweak to get a sound 
blaster to work if you're installing one by hand with a screw driver and a 
text editor.

To make a new kernel, you first have to configure it.  Type the following:

make menuconfig

This is a menu driven interface with lots of help explaining what everything 
does.  Spend an afternoon and read all the help entries.  There is also a 
"make xconfig" if you want to use a mouse-based GUI instead of text menus.  
They should be functionally equivalent, though.

When you exit it'll prompt you to save your changes.  Do so.  If you want to 
copy the configuration from one kernel to another (I.E. you have a kernel 
configured the way you want it, and you want the new one to start out with 
the same basic config and only tweak the new stuff), you copy the file 
".config" from one directory to another.  (It comes from/goes into the same 
directory with the README and CREDITS files.  If you dont' see it try ls -la 
to show all files, files starting with a period are nomally hidden.  Unix 
doesn't have a "hidden" attribute, it uses an initial period character 
instead.)  You still have to run "make menuconfig" in the new directory 
anyway after copying ".config", and save the config file when you exit.  It 
creates some other files derived from that one.  To do this step without 
bringing up the menu (just taking the default values for anything that's was 
recently added into the new kernel version), try "make oldconfig".

To actually compile and install the kernel, type the following (as "root"):

make clean dep bzImage modules install modules_install

This will do everything at once.  Again, you need to be the root user to 
install a new kernel.  Here's what those steps mean individually:

Make clean: delete anything left over from an old config (shouldn't be 
required, makes it rebuild everything from the ground up.  This deletes temp 
files, but isn't a full 100% sanitization.  To delete everything that didn't 
come with your distribution and return your source tree to a pristine state, 
the command is "make mrproper".  You probably have to rerun make menuconfig 
and make dep after doing this.)

Make dep: make the dependencies.  It's a step you have to do after 
significantly changing what gets installed in menuconfig.  There's talk of 
making this go away in 2.5 so it'll happen automatically, but for 2.4 you 
still need to do it after running menuconfig.

Make bzImage: make the actually installable kernel image file.  The actual 
file created is "bzImage" in the subdirectory "arch/i386/boot", if you're 
curious.  Yes, the I is capitalised, and Linux is case sensitive.

Make modules: compile all the dynamically loadable device drivers.  If you 
disabled module support in your configuration (and selected all the various 
pieces you want to be statically linked into the bzImage file), you don't 
need to do this.  (It will in fact generate an error message if you try to do 
this with module support disabled by menuconfig.)

Make install: copy the bzImage file (and a half-dozen other supporting files) 
into the /boot directory, and run the "lilo" command (Linux Loader) to write 
a new boot sector to your hard drive that says where to find the new kernel.

Make modules_install: copy the dynamically loadable device drivers into the 
appropriate place under the /lib/modules directory so the kernel knows where 
to find them when it needs them.

One other little detail: if you're installing a NEW kernel, it will be 
installed with a different name than the old kernel, so you have to edit the 
file /etc/lilo.conf and re-run lilo yourself (as root, just type "lilo" at 
the command line) to create a new boot sector pointing to your new kernel.

Your old kernel (if it's a different version, and they generally are your 
first time) should still be there.  This is a GOOD thing.  Worst case 
scenario, if your new kernel doesn't work, you can boot back to the old one.  
(Lilo gives you a cursor-driven menu these days.  Back in the old days 
(spring fo 2000) Lilo was a text mode prompt where you had to type in your 
kernel name to tell Lilo what to boot and know to hit "tab" to get a list of 
available options.  Uphill.  Both ways.

So what you PROBABLY want to do when editing your existing lilo.conf is 
create a second copy of your "image=" block (and the indented lines after 
it), and edit THAT one, leaving an original copy in there.  This will give 
you multiple entries in the lilo menu, the first one in the list is the 
default.  (Well, it is if there's no line up top that says "default=linux" or 
some such.  It indicates the "label" tag of which image block contains the 
default kernel that it'll boot to if you don't make a selection during 
bootup.)

Read both "man lilo" and "man lilo.conf" to see what all the above means...

Don't forget to re-run lilo after editing lilo.conf to copy your changes to 
the boot sector.  They don't count otherwise.  (And keep a "known working" 
kernel in lilo when trying out new ones.  Having a system that won't boot at 
all is no fun.  You can delete old cruft out of the /boot directory once 
you're happy with the new one.)

Except to break things as you go along.  That's the only way to learn.  Take 
it slow at first.

Common mistakes:

Forgetting to run lilo.  (The system may still boot.  Even if you've deleted 
the old kernel file out of the /boot directory.  The boot sector doesn't care 
if it's in the filesystem, just that the data's there on disk, which it still 
is until it's re-used.  It may work for a while.  And then stop suddenly one 
day when you re-boot and oh-oh, bad kernel image 'cause something re-used the 
space.)

Trying to boot to a root partition that needs a loadable kernel module to 
access it.  (Chicken and egg problem, if you make IDE support a module and 
then try to boot from an IDE drive, it needs to the module before it can 
access the drive to load the module.  Whatever device your root partition is 
on has to be compiled into the kernel.  [*] instead of [M] in menuconfig.  
There is a way around this via booting to an "initial ramdisk", but that's 
beyond the scope of this discussion, read the bootdisk-howto (google can find 
it, google could probably find Jimmy Hoffa) for more info on this.)

Not keeping an old kernel file around and a "lilo" entry that points to it.  
(If it doesn't boot, how do you get in to fix it?  May I suggest Tom's Root 
Boot from http://www.toms.net/rb/home.html plus a lot of time and caffiene...)

Forgetting to include the filesystem type your root partition is.  (If you 
formatted the root partition reiserfs, and you didn't compile in reiserfs...  
No, it can't be a module either if it's something the system needs to be able 
to read the root partition.)

If you get a "patch" file that needs to be applied to your kernel, you can 
use the patch command.  The general form of it is to cd into your linux 
source directory (where that README file is, the same place .config lives, 
not into the various subdirectories under that unless the patch says to) and 
run:

patch -p1 < patchfile

You will probably need to provide a path to where the patch file is unless 
you copied it into your kernel source directory.

There's a man page for the patch command (type "man patch"), which was 
written by the Free Software Foundation and as such takes rather a long time 
to read, but is probably worth it.

If you want to know more about this there are zillions of other fun documents 
on www.linuxdoc.org.  That's the linux documentation project, and it's loads 
of fun.  The "howto" files are especially nice.  How to make your own 
bootdisk.  How to configure a sound card by hand...

Rob
