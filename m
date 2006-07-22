Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWGVQtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWGVQtZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWGVQtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:49:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:27079 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750878AbWGVQtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:49:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YUezJhMDt6KwVJ0cHu11WzlDWKaMrX1PTYbe7Hatg83Cj3f5RBeZBZPiILkxu2rSIS24iRT1W5wTa+GgUGnjHuReWoIqd0qlO3nBymsYzHV/qaVWa1c97Z/Z2ki1AbWkfGZAmkE/GgKW3lDNjYuuj4o+1vRbr8+KqcdCMkZbU7U=
Message-ID: <806dafc20607220949y4ebbc88av99e0e689e1fd687e@mail.gmail.com>
Date: Sat, 22 Jul 2006 12:49:22 -0400
From: "Christopher Montgomery" <xiphmont@gmail.com>
To: "Ian Stirling" <tandra@mauve.plus.com>
Subject: Re: [linux-usb-devel] USB snd-usb-audio wedges lsusb when unplugged while playing sound.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44C21635.5090808@mauve.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44C21635.5090808@mauve.plus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/06, Ian Stirling <tandra@mauve.plus.com> wrote:
> Config/... as my earlier message on USB - though with the bandwidth
> enforcement
> turned off so it actually plays sound, when plugged into the USB1 port.
>
> 2.6.17.
>
> Basically - playing sound with
> mplayer -ao alsa:device=hw=1 or whatever - and then unplugging the
> soundcard completely wedges lsusb/usb configuration, until the mplayer
> process is killed.

This sounds like the well known EPIPE problem in usb-audio and one I
intended to fix after dealing with the ehci scheduler.

It boils down to this: although the low-level usb code is properly
reporting and distinguishing error conditions, usb-audio translates
just about everything that goes wrong into 'EPIPE'.  Because an
application has no way to distinguish temporary from permanent errors
(and the coding docs specify that the app resubmit), it immediately
retries and gets another EPIPE.  This infinite retry loop places
enough system load on the machine that it may well even stop pinging.
Although the *machine* is not wedged, if this happens in a realtime
thread (eg, jack using a usb-audio device), it may well be hosed
enough to become unrecoverable.

Monty
