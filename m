Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTCDJC3>; Tue, 4 Mar 2003 04:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267992AbTCDJC3>; Tue, 4 Mar 2003 04:02:29 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:25828 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264938AbTCDJC0>;
	Tue, 4 Mar 2003 04:02:26 -0500
Date: Tue, 4 Mar 2003 10:12:54 +0100
From: bert hubert <ahu@ds9a.nl>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Roger Luethi <rl@hellgate.ch>, Troels Haugboelle <troels_h@astro.ku.dk>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Message-ID: <20030304091254.GA16556@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Roger Luethi <rl@hellgate.ch>,
	Troels Haugboelle <troels_h@astro.ku.dk>,
	Pavel Machek <pavel@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046657290.8668.33.camel@laptop-linux.cunninghams> <20030303113153.GA18563@outpost.ds9a.nl> <20030303122325.GA20929@atrey.karlin.mff.cuni.cz> <20030303123551.GA19859@outpost.ds9a.nl> <20030303124133.GH20929@atrey.karlin.mff.cuni.cz> <1046700474.3782.197.camel@localhost> <20030303143006.GA1289@k3.hellgate.ch> <1046729210.1850.8.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046729210.1850.8.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 11:06:50AM +1300, Nigel Cunningham wrote:

> You were hitting the BUG_ON before swsusp was even trying to write the
> image?!! That is interesting! Since count_and_copy is first called post
> driver suspend in the current version, perhaps they are somehow related.

Sure, I get this too:

 It now says (copied by hand):  
 
         freeing memory: .....................|
 (this 'freeing' takes ages, around 30 seconds, while in progress, the disk
  light blinks every once in a while, perhaps each time while a dot is being
 printed)
         syncing disks
         suspending devices
         suspending device c0418bcc
         suspending devices
         suspending device c0418bcc
         suspending: hda ------------------[ cut here
         trace back:
   
           device_susp()
           drivers_susp()
           do_software_susp()


This happens, I think, from here in kernel/suspend.c:

/* Called from process context */
static int drivers_suspend(void)
{
        device_suspend(4, SUSPEND_NOTIFY);
	device_suspend(4, SUSPEND_SAVE_STATE);
        device_suspend(4, SUSPEND_DISABLE);
	...

I think the problem occurs on the second call, SUSPEND_SAVE_STATE:

static int idedisk_suspend(struct device *dev, u32 state, u32 level)
{
        ide_drive_t *drive = dev->driver_data;

        printk("Suspending device %p\n", dev->driver_data);

        /* I hope that every freeze operation from the upper levels have
         * already been done...
         */

        if (level != SUSPEND_SAVE_STATE)
                return 0;

        /* set the drive to standby */
        printk(KERN_INFO "suspending: %s ", drive->name);
        do_idedisk_standby(drive);
        drive->blocked = 1;

        BUG_ON (HWGROUP(drive)->handler);  // <----- this BUGs
        return 0;
}

Regards,

bert


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
