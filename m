Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTLBVEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 16:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTLBVEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 16:04:52 -0500
Received: from cruftix.physics.uiowa.edu ([128.255.70.79]:30351 "EHLO cruftix")
	by vger.kernel.org with ESMTP id S264398AbTLBVEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 16:04:50 -0500
Date: Tue, 2 Dec 2003 15:04:43 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vanilla 2.6.0-test11 and CS4236 card
Message-ID: <20031202210441.GF5475@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	linux-kernel@vger.kernel.org
References: <20031202170637.GD5475@digitasaru.net> <s5hsmk3ceia.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsmk3ceia.wl@alsa2.suse.de>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An update.  I've traced the problems down into snd_cs4231_probe().
After adding diagnostic printk statements, I get the following:
     *vcs4231_inb() returned 0xff
     *val is now 0x80
     *cs4231_inb & CS4231_INIT returned TRUE
     cs4231: port = 0x530, id = 0x0
     id is incorrect (id=0x00, but should be 0x0a)
    err in call to snd_cs4231_probe
err in call to snd_cs4231_create!
err running snd_cs4236_create!
CS4236+ soundcard not found or device busy
[all but the last line are mine].  the stuff prefixed by "*" comes from
  here in snd_cs4231_probe:

	for (i = 0; i < 50; i++) {
		mb();
		val = cs4231_inb(chip, CS4231P(REGSEL));
		printk("     *vcs4231_inb() returned 0x%0x\n", val);
		val &= CS4231_INIT;
		printk("     *val is now 0x%0x\n", val);
		/*if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT) {*/
		if (val) {
		  printk("     *cs4231_inb & CS4231_INIT returned TRUE\n");
			udelay(2000);
		} else {
			spin_lock_irqsave(&chip->reg_lock, flags);
			snd_cs4231_out(chip, CS4231_MISC_INFO, CS4231_MODE2);
			id = snd_cs4231_in(chip, CS4231_MISC_INFO) & 0x0f;
			printk("     *detecting id: id=%02x\n", id);
			spin_unlock_irqrestore(&chip->reg_lock, flags);
			if (id == 0x0a)
				break;	/* this is valid value */
		}
	}

Anyone know what the io port here does, and what the different return
  values are?  Pointers to documentation is more than welcome!  :)

Thanks!

-Joseph
-- 
trelane@digitasaru.net--------------------------------------------------
"We continue to live in a world where all our know-how is locked into
 binary files in an unknown format. If our documents are our corporate
 memory, Microsoft still has us all condemned to Alzheimer's."
    --Simon Phipps, http://theregister.com/content/4/30410.html




