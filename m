Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278275AbRKXNgR>; Sat, 24 Nov 2001 08:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278381AbRKXNgG>; Sat, 24 Nov 2001 08:36:06 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:38928 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278275AbRKXNf4>;
	Sat, 24 Nov 2001 08:35:56 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kaih@khms.westfalen.de (Kai Henningsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: is 2.4.15 really available at www.kernel.org? 
In-Reply-To: Your message of "24 Nov 2001 12:01:00 +0200."
             <8DUadXKmw-B@khms.westfalen.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 25 Nov 2001 00:35:41 +1100
Message-ID: <2450.1006608941@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Nov 2001 12:01:00 +0200, 
kaih@khms.westfalen.de (Kai Henningsen) wrote:
>mhw@wittsend.com (Michael H. Warfield)  wrote on 23.11.01 in <20011123185407.A3499@alcove.wittsend.com>:
>> 	I typically keep 4 to six fall back versions in each of the
>> 2.2 and 2.4 lines active and want (or occasionally need) to target specific
>> versions, especially when I'm testing preX kernels and my device driver.
>> You are way TOO simple.
>
>I keep more (though I really don't need that many) ... and I *do* add text  
>to kernel names myself.
>
>So I wrote a (very quick-and-dirty) little Perl script. Maybe a variant of  
>that works for other people, too.

kbuild 2.5 has standard support for running user specific install
scripts after installing the bootable kernel and modules.  That is, the
"update my bootloader" phase can be automated and will propagate from
one .config to the next when you make oldconfig.

bool 'Run a post-install script or command' CONFIG_INSTALL_SCRIPT
if [ "$CONFIG_INSTALL_SCRIPT" = "y" ]; then
  string '  Post-install script or command name' CONFIG_INSTALL_SCRIPT_NAME ""
fi

$(CONFIG_INSTALL_SCRIPT_NAME) is run with several environment variables
set, including the kernel release.  There is a sample install script in
scripts/lilo_new_kernel which will satisfy most people, if not you can
copy and edit it to suit.

#!/bin/sh
#
#  This is a sample script to add a new kernel to /etc/lilo.conf.  If it
#  does not do what you want, copy this script to somewhere outside the
#  kernel, change the copy and point your .config at the modified copy.
#  Then you do not need to change the script when you upgrade your kernel.
#

label=$(echo "$KERNELRELEASE" | cut -c1-15)
if ! grep "label=$label\$" /etc/lilo.conf > /dev/null
then
  ed /etc/lilo.conf > /dev/null 2>&1 <<EODATA 
/^image/
i
image=$CONFIG_INSTALL_PREFIX_NAME$CONFIG_INSTALL_KERNEL_NAME
	label=$label
	optional

.
w
q
EODATA
  if [ ! $? ]
  then
    echo edit of /etc/lilo.conf failed
    exit 1
  fi
fi
lilo

