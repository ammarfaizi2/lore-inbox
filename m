Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267183AbTA0MRi>; Mon, 27 Jan 2003 07:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267185AbTA0MRi>; Mon, 27 Jan 2003 07:17:38 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:4544 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267183AbTA0MRi>;
	Mon, 27 Jan 2003 07:17:38 -0500
Date: Mon, 27 Jan 2003 13:26:54 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301271226.NAA10528@harpo.it.uu.se>
To: vojtech@suse.cz
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42
Cc: linux-kernel@vger.kernel.org, ttsig@tuxyturvy.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jan 2003 21:19:52 -0500, Tom Sightler wrote:
>> Hmm, interesting. Can you try disabling some of the probes for
>> extended keyboards in atkbd.c to see if some of them could confuse
>> your keyboard so that the BIOS doesn't like it after boot? Also you
>> may want to kill the keyboard reset on reboot ... (atkbd_cleanup) ...
>
>I've been following this because my Dell Latitude C810 has the
>"keyboard/mouse doesn't work after reboot" with all of the recent 2.5.x
>kernel that I have tried.
>
>When I saw the suggestion above to try removing the keyboard reset I
>thought that was just too easy to pass up giving it a try.  Sure enough,
>removing just the one line that preforms the keyboard reset from
>atkbd_cleanup solves the problem for me.

I tried that too and it eliminated the keyboard error problem on my CPi.
(Strangely enough, when I tried the same hack with the 2.5.42 kernel
some time ago it did not help. Oh well.)

I added some logging to atkbd_command(), and found that GSCANSET
always returns 22 (decimal), but SSCANSET with 22 fails and
triggers the BIOS keyboard error. So what happens is that atkbd_set_3()
does GSCANSET and stores 22 in atkbd->oldset. Then it issues
SSCANSET with 2, checks the result with GSCANSET, gets 22, and
assumes 2 since 22 != 3. Just before reboot, atkbd_cleanup() does
SSCANSET with 22 (from atkb->oldset), which fails (though atkbd
doesn't check this) and later triggers the BIOS keyboard error.

Either removing the SSCANSET from atkbd_cleanup(), or changing
atkbd->oldset from 22 to 2, solves my CPi's keyboard problems.

/Mikael
