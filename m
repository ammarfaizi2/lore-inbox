Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280521AbRJaVMl>; Wed, 31 Oct 2001 16:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280522AbRJaVMc>; Wed, 31 Oct 2001 16:12:32 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:35082 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S280521AbRJaVMN>;
	Wed, 31 Oct 2001 16:12:13 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Richard B. Johnson" <root@chaos.analogic.com>
Date: Wed, 31 Oct 2001 22:11:09 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Patch] Re: Nasty suprise with uptime
CC: Andreas Dilger <adilger@turbolabs.com>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <7DFB419183D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Oct 01 at 15:39, Richard B. Johnson wrote:
> A fix exists, though. The existing, possibly wrong, boot time could
> be grabbed during the set-time sys-call, the difference between the
> existing (wrong) time and the boot time could be calculated, the
> new (correct) time could be set, then the boot-time would be changed
> to the new correct time, minus the calculated difference. This
> would result in a correct boot-time.
> 
>     dif_time = time - boot_time;
>         time = new_time;
>         boot_time = time - dif_time;
> 
> Uptime could then be present time minus boot time. No mucking with
> timer ticks are required.

Hi,
  this reminds me. Year or so ago there was patch from someone, which 
detected jiffies overflow in /proc/uptime proc_read() code, so only thing
you had to do was run 'uptime', 'w', 'top' or something like that
every 497 days - you can schedule it as cron job for Jan 1, 0:00:00,
to find some workoholics.

  Patch was something like:

...  
static unsigned long long jiffies_hi = 0;
static unsigned long old_jiffies = 0;
unsigned long jiffy_cache;

/* some spinlock or inode lock or something like that */
jiffy_cache = jiffies;
if (jiffy_cache < old_jiffies) {
   jiffies_hi += 1ULL << BITS_PER_LONG;
}
old_jiffies = jiffy_cache;
grand_jiffies = jiffies_hi + jiffy_cache;
/* unlock */
/* now do division and all strange things to format number for userspace */
...

Even if you add running uptime every year to your crontab, 
it will consume less than 700,000,000 CPU cycles consumed by just 64bit
inc in timer interrupt.
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
