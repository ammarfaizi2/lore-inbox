Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSKBWAe>; Sat, 2 Nov 2002 17:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSKBWAe>; Sat, 2 Nov 2002 17:00:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53772 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261456AbSKBWAb>; Sat, 2 Nov 2002 17:00:31 -0500
Date: Sat, 2 Nov 2002 22:06:58 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Patrick Finnegan <pat@purdueriots.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021102220658.C8549@flint.arm.linux.org.uk>
Mail-Followup-To: Patrick Finnegan <pat@purdueriots.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com>; from pat@purdueriots.com on Sat, Nov 02, 2002 at 04:57:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 04:57:31PM -0500, Patrick Finnegan wrote:
> Personally, it makes no difference to me which library is used.  I'm
> doubtful I'll use anything other than menuconfig unless it makes my life a
> *whole* lot easier. I'd say 'choose one and get on with it.'

Looking at my menuconfig patch (that's been mailed to lkml numerious
times), the old Menuconfig script and checking mconf.c, it looks like
mconf.c isn't checking for half the errors that the old Menuconfig
script used to / would've been checking with my patch.

Oh, and another thing I've noticed is that mconf does nothing if it
fails to execute lxdialog - it doesn't tell you _why_ it's doing
nothing.  It just says something like "Not saving configuration."

The last mailing of my patch was a while ago, so I'll reproduce it
here:

| This patch fixes a failure case in menuconfig which can occur if a kernel
| tree is configured on one architecture with menuconfig, and then attempted
| to be reconfigured on another architecture.
| 
| The kernel detects that the binary can't be run on the second architecture
| and correctly returns the appropriate error code.  However, the Menuconfig
| script ignores this error and retries endlessly, appearing to hang.
| 
| This patch makes menuconfig display a message and exit rather than
| endlessly looping.
| 
|  scripts/Menuconfig |   20 ++++++++++++++++++++
|  1 files changed, 20 insertions
| 
| diff -ur orig/scripts/Menuconfig linux/scripts/Menuconfig
| --- orig/scripts/Menuconfig	Sat Oct 12 10:02:17 2002
| +++ linux/scripts/Menuconfig	Sat Oct 12 10:45:13 2002
| @@ -909,6 +909,26 @@
|  			cleanup
|  			exit 139
|  			;;
| +		126|127)
| +			stty sane
| +			clear
| +			cat << EOM
| +
| +There seems to be a problem with the lxdialog companion utility which is
| +built prior to running Menuconfig.  lxdialog could not be found, or could
| +not be executed.  This can be caused when lxdialog has been built for a
| +different architecture.
| +
| +You should rebuild lxdialog.  This can be done by moving to the
| +/usr/src/linux/scripts/lxdialog directory and issuing the "make clean all"
| +command.
| +
| +If the problem persists, you may email the maintainer <mec@shout.net> or
| +post a message to <linux-kernel@vger.kernel.org> for additional assistance. 
| +
| +EOM
| +			cleanup
| +			exit 1
|  		esac
|  	done
|  }
| 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

