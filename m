Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274194AbRJYN5D>; Thu, 25 Oct 2001 09:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274255AbRJYN4x>; Thu, 25 Oct 2001 09:56:53 -0400
Received: from s1.relay.oleane.net ([195.25.12.48]:10680 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S274194AbRJYN4k>; Thu, 25 Oct 2001 09:56:40 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Thu, 25 Oct 2001 16:57:02 +0200
Message-Id: <20011025145702.30900@smtp.adsl.oleane.com>
In-Reply-To: <E15wjWq-0004ht-00@the-village.bc.nu>
In-Reply-To: <E15wjWq-0004ht-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> My point about using a semaphore was to avoid getting mixer ioctls
>> banging the HW while it is shut down.
>
>Yes I can follow that - you want to avoid the aclink being shut down while
>active. That seems to be just part of the ordering. I'd also put the ac97
>save/restore in the ac97_codec.c stuff - lets write it once 8)

Not exactly ;) Since sleep/resume on pmac is somewhat asynchronous, things
like sound (which in my case can take 1 to 2 seconds to come back to
to calibration delay of the chip) is done async. So userland is already
running again, and may be hitting the driver with various mixer ioctls,
while my HW isn't yet ready to get them (nothing fancy here).

I do also have the problem of having the sound chip on an i2c bus on some
machiones, and so the problem of dependencies between the i2c controller
and the sound driver (samples use a separate i2s bus), but this is also
easily fixed by either having the sound chip a child of the i2c controller,
or just shutting down the i2c controller as part of the platform code
which is what I do now.

I did various experiments doing CD and/or MP3 playback and putting the
machine to sleep. The "smoothest" result I obtained was using this
semaphore on driver entrypoints. This "cleanly" suspends the sound app
on it's next call to the sleeping sound driver and resume it when the
sound driver is ready. Since the sound chip takes forever to come back,
it's long enough for disk & cd to be fully back up, and the player
not to skip when resumed :)

Ben.



