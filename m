Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284521AbRLER3T>; Wed, 5 Dec 2001 12:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284525AbRLER3N>; Wed, 5 Dec 2001 12:29:13 -0500
Received: from hoju-ext.nks.net ([216.139.204.180]:14227 "EHLO
	hoju-ext.nks.net") by vger.kernel.org with ESMTP id <S284522AbRLER3B>;
	Wed, 5 Dec 2001 12:29:01 -0500
Subject: Random "File size limit exceeded" under 2.4
From: Derek Glidden <dglidden@illusionary.com>
To: linux-kernel@vger.kernel.org
Cc: bugs@linux-ide.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Dec 2001 12:28:51 -0500
Message-Id: <1007573331.1809.6.camel@two>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been experiencing random and occasional encounters with "File size
limit exceeded" errors under 2.4 kernels when trying to make
filesystems.  Unfortunately, there's no real rhyme or reason when this
occurs, except that - usually - if I recompile a kernel or do a big
rsync on a box that isn't giving me these problems, and then try to mkfs
something, I'll encounter it.  And if I'm unable to mkfs a device
because of this error - usually - if I reboot the box, it goes away.

Note that it has *nothing* to do with the device I'm trying to mkfs
being over 2GB!  Once I start experiencing this, I've had *any* device
that I try to mkfs error out with SIGXFSZ until I rebooted.  (Usually,
of course.  I hate bugs that aren't consistent....)

I know I've seen this with at least stock 2.4.10, 2.4.13 and 2.4.14 and
also 2.4.10 and 2.4.14 with XFS patches.  There may have been other
earlier versions in there were I ran into it but ignored it or
overlooked it.  All our boxes here at work are more-or-less stock Debian
2.2 with upgraded modutils to support running 2.4 kernels.

I don't have any particular correlation between hardware except that all
of them have had IDE drives in them so my only real suspicion is some
bizarrity in the IDE drivers.

I've got a machine that's experiencing this problem right now and I've
done "strace" on both mke2fs and mkreiserfs to see what the results
would be and it's a little wierd and beyond my interpretation
capabilities.  Here are the last few lines from both of those straces:

mke2fs.strace:

lseek(4, 2015346688, SEEK_SET)          = 2015346688
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
32768) = 32768
lseek(4, 2015379456, SEEK_SET)          = 2015379456
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
write(1, "\10\10\10\10\10", 5)          = 5
write(1, "16/72", 5)                    = 5
_llseek(4, 18446744071562084352, [2147500032], SEEK_SET) = 0
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
32768) = -1 EFBIG (File too large)
--- SIGXFSZ (File size limit exceeded) ---
+++ killed by SIGXFSZ +++


mkreiserfs.strace:

_llseek(4, 1744830464, [1744830464], SEEK_SET) = 0
write(4, "\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, 1879048192, [1879048192], SEEK_SET) = 0
write(4, "\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, 2013265920, [2013265920], SEEK_SET) = 0
write(4, "\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, 18446744071562067968, [2147483648], SEEK_SET) = 0
write(4, "\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = -1 EFBIG (File too large)
--- SIGXFSZ (File size limit exceeded) ---
+++ killed by SIGXFSZ +++


And this is the output of "sfdisk -l" for that box:

# sfdisk -l

Disk /dev/hda: 1655 cylinders, 255 heads, 63 sectors/track
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from
0

   Device Boot Start     End   #cyls   #blocks   Id  System
/dev/hda1          0+     32      33-   265072   83  Linux
/dev/hda2         33      98      66    530145   82  Linux swap
/dev/hda3         99     164      66    530145   83  Linux
/dev/hda4        165    1654    1490  11968425    5  Extended
/dev/hda5        165+    413     249-  2000092   83  Linux
/dev/hda6        414+    479      66-   530144+  83  Linux
/dev/hda7        480+   1654    1175-  9438187   83  Linux


Now it looks to me that in both cases, the mkfs is trying to seek well
beyond the end of the device for some reason. Except that the drive
isn't anything unusual - it's a 13GB Maxtor 91360U4 and the IDE
interface is reported as "VIA vt82c596a (rev 09) IDE UDMA33 controller
on pci00:07.1" which the VIA line of controllers has generally been very
well supported under Linux, in my experience.  Plus, as I said, I've
seen this on a number of boxen with different drives and IDE controllers
in them, so I don't see it being particular to a specific drive or
controller.

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#!/usr/bin/perl -w
$_='while(read+STDIN,$_,2048){$a=29;$b=73;$c=142;$t=255;@t=map
{$_%16or$t^=$c^=($m=(11,10,116,100,11,122,20,100)[$_/16%8])&110;
$t^=(72,@z=(64,72,$a^=12*($_%16-2?0:$m&17)),$b^=$_%64?12:0,@z)
[$_%8]}(16..271);if((@a=unx"C*",$_)[20]&48){$h=5;$_=unxb24,join
"",@b=map{xB8,unxb8,chr($_^$a[--$h+84])}@ARGV;s/...$/1$&/;$d=
unxV,xb25,$_;$e=256|(ord$b[4])<<9|ord$b[3];$d=$d>>8^($f=$t&($d
>>12^$d>>4^$d^$d/8))<<17,$e=$e>>8^($t&($g=($q=$e>>14&7^$e)^$q*
8^$q<<6))<<9,$_=$t[$_]^(($h>>=8)+=$f+(~$g&$t))for@a[128..$#a]}
print+x"C*",@a}';s/x/pack+/g;eval 

usage: qrpff 153 2 8 105 225 < /mnt/dvd/VOB_FILENAME \
    | extract_mpeg2 | mpeg2dec - 

         http://www.cs.cmu.edu/~dst/DeCSS/Gallery/
http://www.eff.org/                   http://www.anti-dmca.org/

