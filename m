Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266337AbSKGEgW>; Wed, 6 Nov 2002 23:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266343AbSKGEgW>; Wed, 6 Nov 2002 23:36:22 -0500
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:26518 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S266337AbSKGEgV>; Wed, 6 Nov 2002 23:36:21 -0500
Date: Wed, 6 Nov 2002 21:42:58 -0700 (MST)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Matt Simonsen <matt_lists@careercast.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: build kernel for server farm
In-Reply-To: <1036620009.1332.12.camel@mattsworkstation>
Message-ID: <Pine.LNX.4.44.0211062136280.10755-100000@skuld.mtroyal.ab.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Nov 2002, Matt Simonsen wrote:

> I am pretty familiar with the build process and kernel install for a
> single Linux box, but I wanted to confirm I'm doing things in a sane way
> for a large deployment. All the machines are the same hardware and
> running standard setups.
> 
> First, I plan on compiling the kernel on a development box. From there
> my plan is basically tar /usr/src/linux, copy to each box, untar, copy
> bzImage and System.map to /boot, run make modules_install, edit
> lilo.conf, run lilo.

If all of your systems are *identical*, try something like rsync
or rdist (both can be told to use ssh too).  

1) build your kernel and install it on your development box
2) do a test boot.  Ensure everything is there for you as needed
3) build a Distfile like so:
##################
HOSTS = (
host1
host2
host3
)

KERNEL = (
/boot
/etc/lilo.conf
/etc/grub.conf
)

kernel:
${KERNEL} -> ${HOSTS}
	install ;
# could use a cmdspecial after this to run lilo if needed

modules:
/lib/modules -> ${HOSTS}
	install ;

################

Now, run rdist -P/usr/bin/ssh -overify -f Distfile

You should see it verify what will be updated on hosts[1234...]

Once that's done run a shell loop to reboot the systems as required

for i in host1 host2 host3 host4 ; do
	ssh $i "shutdown -r now"
done

If they are not identical, you can do the same thing, only different /boot
and /lib/module directories to each host would be required as well
as seperate Distfile rules for each host or group of hosts.

Hope that helps.

Regards
James Bourne

> 
> Tips? Comments?
> 
> Thanks 
> Matt
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."


