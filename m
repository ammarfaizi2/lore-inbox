Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWINQSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWINQSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 12:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWINQSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 12:18:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:21708 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750968AbWINQSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 12:18:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CWsDy3at2CrtGopNN1d1wSsyzkbhO6uMSrgX9whs3NoCB3e3E+CzxojSRAKebmrEUdnubqeJrAB+aRQxKFw8ePQjRYSuxW47Xw9qO4qrJvxHWneWd4qrbQre7WBsAIZW2fBeED97qupLsiG5x4KRs8AWs7cROZCtlTlLMahG7HE=
Message-ID: <d120d5000609140918j18d68a4dmd9d9e1e72d2fd718@mail.gmail.com>
Date: Thu, 14 Sep 2006 12:18:01 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jiri Kosina" <jikos@jikos.cz>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
Cc: lkml <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <Pine.LNX.4.64.0609141754480.2721@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
	 <200609132200.51342.dtor@insightbb.com>
	 <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz>
	 <d120d5000609140618h6e929883u2ed82d1cab677e57@mail.gmail.com>
	 <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz>
	 <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com>
	 <Pine.LNX.4.64.0609141700250.2721@twin.jikos.cz>
	 <d120d5000609140851r2299c64cv8b0a365be795a1bc@mail.gmail.com>
	 <Pine.LNX.4.64.0609141754480.2721@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/06, Jiri Kosina <jikos@jikos.cz> wrote:
> On Thu, 14 Sep 2006, Dmitry Torokhov wrote:
>
> > Not yet ;) Is there a way to hide the depth in the spinlock/mutex
> > structure itself so that initialization code could do
> > spin_lock_init_nested() and spare the rest of the code from that
> > knowledge?
>
> (shortened CC list a bit)
>
> In fact I am not sure what you mean. On every lock and unlock operation,
> in case of recursive locking (which our case is), you have to provide
> class identifier, which is used to distinguish if the lock is of the same
> instance, or a different one (deeper or higher in the locking hierarchy).
> There is no way how spin_lock() or mutex_lock() can know this
> "automatically", you always have to provide the nesting level from
> outside, as it depends on the ordering hierarchy, which locking primitives
> are totally unaware of.
>

Well, we do not really care about nestiness do we? What we trying to
achieve is to teach lockdep that 2 locks while appear as the lame lock
in fact are different and protect 2 different structures. Ideally
lockdep should track every lock individually (based for example on its
address) but that would be too taxing so we need to help it. In your
implementation you embed this data into structure/code using lock, but
this information could be instilled into the lock itself upon
initialization and spin_[un]lock() implementation could be taught to
use this data thus making specialized spin_[un]lock*_nested()
functions unnecessary.

-- 
Dmitry
