Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWAEW1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWAEW1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWAEW1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:27:08 -0500
Received: from isilmar.linta.de ([213.239.214.66]:40941 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750861AbWAEW1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:27:07 -0500
Date: Thu, 5 Jan 2006 23:27:05 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060105222705.GA12242@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Pavel Machek <pavel@ucw.cz>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20051227213439.GA1884@elf.ucw.cz> <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com> <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net> <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net> <20060105215528.GF2095@elf.ucw.cz> <20060105221334.GA925@isilmar.linta.de> <20060105222338.GG2095@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105222338.GG2095@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 11:23:38PM +0100, Pavel Machek wrote:
> > In addition, your patch breaks pcmcia / pcmciautils which already uses
> > numbers (which I already had to change from "3" to "2" before...).
> 
> pcmcia actually uses this? Ouch. Do you just read the power file, or
> do you write to it, too?

Reading and writing. Replacement for "cardctl suspend" and "cardctl resume".


static int pccardctl_power_one(unsigned long socket_no, unsigned int device,
                               unsigned int power)
{
        int ret;
        char file[SYSFS_PATH_MAX];
        struct sysfs_attribute *attr;

        snprintf(file, SYSFS_PATH_MAX,
                 "/sys/bus/pcmcia/devices/%lu.%u/power/state",
                 socket_no, device);

        attr = sysfs_open_attribute(file);
        if (!attr)
                return -ENODEV;

        ret = sysfs_write_attribute(attr, power ? "2" : "0", 1);

        sysfs_close_attribute(attr);

        return (ret);
}


NB: it will break one day, one way or another, when gregkh makes the
/sys/class -> /sys/devices conversion. However, I'd want to try not to break
the new pcmciautils userspace too often...

	Dominik
