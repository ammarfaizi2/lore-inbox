Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284191AbSABVPe>; Wed, 2 Jan 2002 16:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284186AbSABVPZ>; Wed, 2 Jan 2002 16:15:25 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:57547 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S284182AbSABVPI>; Wed, 2 Jan 2002 16:15:08 -0500
Message-ID: <3C337852.1050109@nyc.rr.com>
Date: Wed, 02 Jan 2002 16:14:58 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: system.map
In-Reply-To: <fa.ephh22v.1ljqarg@ifi.uio.no> <fa.hmqrtsv.13jqup8@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Covell wrote:

> On Wednesday 02 January 2002 13:39, Tony Hoyle wrote:
> 
>>Timothy Covell wrote:
>>
>>>	Of course, you can copy over the new System.map
>>>file to /boot,  but their is no (easy) way of having more than
>>>one active version via "lilo" or "grub".   And that could be
>>>considered a deficiency of the Linux OS.
>>>
>>????  Just call it System.map-2.2.17, System.map-2.5.1, etc.  Sounds
>>pretty 'easy' to me.
>>
>>'make install' does all this for you, btw.
>>
>>Tony
>>
> 
> Not on grub.  I quote:
> 	It is also possible to do "make install" if you have lilo 
> 	installed to suit the kernel makefiles,
>   	but you may want to check your particular lilo setup first.
> 
> But, on my grub based system, I have to:
> 
> 1.  "make bzlilo"  which creates vmlinuz and System.map 
> and puts them in / and not in /boot.  (make bzlilo is easier to use
> than bzimage)
> 
> 2. cp /vmlinuz /boot/vmlinuz-x.y.x  ;  cp /System.map /boot/System.map-x.y.z
> 
> 3. rm /boot/System.map ; ln -s /boot/System.map-x.y.z /boot/System.map
> 
> 4. vi /boot/grub.conf (or /etc/grub.conf) and put in new kernel boot entry.
> 
> 5. sync;sync;shutdown -r now
> 


None of this sounds incredibly complicated, and, in fact, a scripting 
language (e.g. perl) does quite nicely.

I wrote a little script that does the whole thing for me;
I can think of a bunch of improvements (like writing a new
/etc/lilo.conf file) that can be added with minimal effort:

I'm curious to know what the standard approach to this is.
What other scripts are out there?

#!/usr/bin/perl

# ----------------------------------------------------
# Program:     kernel-install
# Description: This script installs a kernel after it
#              has been built, since "make install"
#              doesn't do it the way I like it.
# ----------------------------------------------------

$srcdir = "/usr/src/linux";

# Origin Files
$kernel = "$srcdir/arch/i386/boot/bzImage";
$map    = "$srcdir/System.map";
$header = "$srcdir/include/linux/kernel.h";
# Destination Directory
$destdir= "/boot";

# Make sure all the files exist
if( !((-e $srcdir) && (-e $header) && (-e $kernel)) ) {
     exit(-1);
}

# getversion will return $version
&getversion;

# Start copying stuff
system("cp $kernel $destdir/vmlinuz-$version");
system("cp $header $destdir/kernel.h-$version");
if( -e $map ) {
system("cp $map $destdir/System.map-$version");
}

# Remove existing softlinks
if( -e "$destdir/vmlinuz" ) {
     unlink("$destdir/vmlinuz");
}
if( -e "$destdir/kernel.h" ) {
     unlink("$destdir/kernel.h");
}
if( -e "$destdir/System.map") {
     unlink("$destdir/System.map");
}

# Recreate links
symlink("$destdir/vmlinuz-$version","$destdir/vmlinuz");
symlink("$destdir/kernel.h-$version","$destdir/kernel.h");
if( -e $map ) {

symlink("$destdir/System.map-$version","$destdir/System.map");
}

# Run LILO
system("lilo");

# ----------------------------------------------------
# Subroutine:  get_kernel_version
# Description: The kernel version for the kernel build
#              can be found in the main Makefile.  
# ----------------------------------------------------
sub getversion
{
    $version = "";
    local($makefile) = "$srcdir/Makefile";
    if( !(-e $makefile) ) {
        exit(-1);
    }    

    open(MAKE,$makefile);
    # We only need the first three lines
    $i = 0;
    local($line);
    while( ($line = <MAKE>) && ($i++ < 4) ) {
    # Grab the name value pairs by splitting line by =
        (local($name), local($value)) = split(/=/, $line, 2);
    # RegExp: Remove whitespace from value
        $_ = $value;
        s/^\s*(.*)\s*$/\1/;
    # Add . between version & level, and level & sublevel
        $version .= $1;
        if( ($i==1) || ($i==2) ) {
            $version .= ".";
        }
    }
    close(MAKE);
}


