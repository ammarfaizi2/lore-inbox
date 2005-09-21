Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbVIUHIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVIUHIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 03:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVIUHIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 03:08:30 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:53746 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751033AbVIUHIa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 03:08:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fn04DN5w0McVEHdj/VsvDYuDCsvHwNTuNiZgImNsxLVGoGi1o+wmxsU9B7hA8H0IouxzQf73dDQ0A5HmkBB5JnliIV4budoqOa210n2oXCeqlv/Jf6/yCkVDVlynY1ApN3VjKZ/e19OuGmtGtwdzLVOgqPKmekJaCZ4fx0LiJ/Y=
Message-ID: <47f5dce305092100085a13a5a7@mail.gmail.com>
Date: Wed, 21 Sep 2005 15:08:26 +0800
From: jayakumar alsa <jayakumar.alsa@gmail.com>
Reply-To: jayakumar.alsa@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.13.1 1/1] CS5535 AUDIO ALSA driver
Cc: perex@suse.cz, mj@ucw.cz, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050920152830.7ef6733b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509190639.j8J6dIM4007948@localhost.localdomain>
	 <20050920152830.7ef6733b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static int __devinit snd_cs5535audio_probe(struct pci_dev *pci,
> > +                                     const struct pci_device_id *pci_id)
> > +{
> > +     static int dev;
> > +     snd_card_t *card;
> > +     cs5535audio_t *cs5535au;
> > +     int err;
> > +
> > +     if (dev >= SNDRV_CARDS)
> > +             return -ENODEV;
> > +     if (!enable[dev]) {
> > +             dev++;
> > +             return -ENOENT;
> > +     }
> > +
> > +     card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
> > +     if (card == NULL)
> > +             return -ENOMEM;
> > +
> > +     if ((err = snd_cs5535audio_create(card, pci, &cs5535au)) < 0) {
> > +             snd_card_free(card);
> > +             return err;
> > +     }
> > +
> > +     if ((err = snd_cs5535audio_mixer(cs5535au)) < 0) {
> > +             snd_card_free(card);
> > +             return err;
> > +     }
> > +
> > +     if ((err = snd_cs5535audio_pcm(cs5535au)) < 0) {
> > +             snd_card_free(card);
> > +             return err;
> > +     }
> > +
> > +     strcpy(card->driver, DRIVER_NAME);
> > +
> > +     strcpy(card->shortname, "CS5535 Audio");
> > +     sprintf(card->longname, "%s %s at 0x%lx, irq %i",
> > +             card->shortname, card->driver,
> > +             cs5535au->port, cs5535au->irq);
> > +
> > +     if ((err = snd_card_register(card)) < 0) {
> > +             snd_card_free(card);
> > +             return err;
> > +     }
> > +
> > +     pci_set_drvdata(pci, card);
> > +     dev++;
> > +     return 0;
> > +}
> 
> Ditto.
> 
> The handling of `dev' is racy ;)

I took a quick look at the dev handling. 

% egrep -B20 "dev\+\+" $lintree/sound/pci/*.c
<snip>
--
../azt3328.c-           return -ENODEV;
../azt3328.c-   if (!enable[dev]) {
../azt3328.c:           dev++;
--
../azt3328.c-
../azt3328.c-   pci_set_drvdata(pci, card);
../azt3328.c:   dev++;
--
../cmipci.c-            return -ENODEV;
../cmipci.c-    if (! enable[dev]) {
../cmipci.c:            dev++;
--
../cmipci.c-    }
../cmipci.c-    pci_set_drvdata(pci, card);
../cmipci.c:    dev++;
--
<snip>

So I think everyone is doing the same thing. I think probe is called
from driver_probe_device through device_add and in this case that's
from pci_bus_add_device/s from pci_do_scan_bus. I think the device
probe functions are therefore called serially and there is no risk of
a race condition. I hope that's right.

Thanks,
jk
