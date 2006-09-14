Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWINNSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWINNSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 09:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWINNSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 09:18:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:4335 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932076AbWINNSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 09:18:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l4HspFGxfkLhOfIQCRV8ySALjcbGYtzTMByy/OlDFsTkhKYHk3GIR53pQ3z+2TPICMltp0cuqxOGlVeE2R2mWK23fY7kctvvtYH2sBqg4S6bphhnNyPCjPrv+kX9f4Gu0ifK+UQdbHu5txdQrKyqZVu5z/JXqoK5K7cMWOLYnsI=
Message-ID: <d120d5000609140618h6e929883u2ed82d1cab677e57@mail.gmail.com>
Date: Thu, 14 Sep 2006 09:18:22 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jiri Kosina" <jikos@jikos.cz>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
Cc: "Andrew Morton" <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Dave Jones" <davej@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
	 <200609132200.51342.dtor@insightbb.com>
	 <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/06, Jiri Kosina <jikos@jikos.cz> wrote:
> On Wed, 13 Sep 2006, Dmitry Torokhov wrote:
>
> > Unfortunately these patches do not solve the problem in general but
> > rather fix one specific codepath. As far as I can see the warnings will
> > return as soon as we add another pass-through port to the link (and I am
> > considering adding a pass-through port to the trackpoint driver so you
> > will get chain like i8042-synaptics-ptport-trackpoint-ptport-psmouse).
> > Plus they are ugly and complicate serio and psmouse cores. I really
> > don't like this *_nested business as it makes the code aware of possible
> > usage patterns instead of just being re-entrant.
>
> Hi Dmitry,
>
> I agree that these patches are ugly, but I wasn't able to think of any
> other way how to get rid of those lockdep warnings.
>
> Of course the lock validator could be extended to provide API such as
> mutex_init_nolockdep(), as you already proposed before, but this also has
> it's drawbacks (for example if any other future user of ps2_init() uses
> the mutex in a really bad way, this would not be detected by lock
> validator).
>
> Another possibility that comes to mind is extending the ps2dev structure
> with a field which would work as an subclass identifier for the device,
> and this field will be then be used as an subclass argument to
> mutex_lock_nested(). However, this requires proper setting of this field
> on the very same places on which my _nested functions are called, so it
> has the same level of generality.
>

Can we add lock_class_key to the struct psmouse and use it to define
per-device mutex class regardless of whether it is a child, grandchild
or a parent?

> Do you have any other idea? I think this should get fixed, otherwise we
> will keep receiving these reports from users again and again.
>

If we can't make lockdep shut up with minimal intervention I might
just change psmouse back to semaphores.

-- 
Dmitry
