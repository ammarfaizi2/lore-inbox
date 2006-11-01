Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752507AbWKAWRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbWKAWRw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 17:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbWKAWRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 17:17:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:50606 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752507AbWKAWRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 17:17:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=eJI5Q3TIOMY3hVX3SoAHcd563rEwS/BX3S9mK4hFkbonu49hbjP/YlSsISk3vYiIH4BRrcOqVbdS6iX9CctMYwywmaRypIVjUAKc8TQIba+4TNUj1yp1G+D1Lp++N6DX/ueUHdayxNGzEq9TJf7KeM6yIzRqclZwlX7ZGTtbgV4=
Message-ID: <f46018bb0611011417s3c436528w3a394531e94cec68@mail.gmail.com>
Date: Wed, 1 Nov 2006 17:17:48 -0500
From: "Holden Karau" <holden@pigscanfly.ca>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised again
Cc: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>,
       "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, "Holden Karau" <holdenk@xandros.com>,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Matthew Wilcox" <matthew@wil.cx>
In-Reply-To: <454908F9.80905@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4548C8AE.2090603@pigscanfly.ca>
	 <20061101164715.GC16154@wohnheim.fh-wedel.de>
	 <f46018bb0611011002h1b3b6e5fjdc6cc032a7503dbd@mail.gmail.com>
	 <20061101202400.GA6888@wohnheim.fh-wedel.de>
	 <454908F9.80905@cfl.rr.com>
X-Google-Sender-Auth: e22962b965eed644
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörn,

If I do
c_bh = kmalloc(blah);
err= -ENOMEM;
if (!c_bh)
    goto error;
//here err = -ENOMEM
... do some stuff...
error:
return err;

It will return -ENOMEM, no? I mean I could set err back to 0 and do
something like:

c_bh = kmalloc(blah);
err= -ENOMEM;
if (!c_bh)
    goto error;
err = 0;
... do some stuf...
error:
return err;

At first glance, at least for me, I'd be scratching my head when I
looked at that.

Also given that this error state is to be an exception not the rule,
if what Phillip suggests is correct, than it would actually be a tiney
be slower. So, all in all I'd rather leave it the way it is :-)

On 11/1/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> I think this is getting into micro-optimization, which is usually bad.
> Also moving the assignment of err outside the body of the if only
> results in slightly faster code in the case where there is an error,
> since you can test and _maybe_ conditionally jump directly to the error:
> label if it is not very far away.  With the assignment in the body, the
> conditional jump must jump to the assignment followed by an
> unconditional jump to the label.
>
> In other words, the only time this micro optimization will be of benefit
> is if you are erroring out most of the time rather than only under
> exceptional conditions, AND the error label isn't too far away for a
> conditional branch to reach.  In other words, just don't do it ;)
>
> Jörn Engel wrote:
> > On Wed, 1 November 2006 13:02:12 -0500, Holden Karau wrote:
> >> On 11/1/06, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> >>> Result would be something like:
> >>>        c_bh = kmalloc(...
> >>>        err = -ENOMEM;
> >>>        if (!c_bh)
> >>>                goto error;
> >> That wouldn't work so well since we always return err,
> >
> > I don't quite follow.  If the branch is taken, err is -ENOMEM.  If the
> > branch is not taken, err is set to 0 with the next instruction.
> >
> > Both methods definitely work.  Whether one is preferrable over the
> > other is imo 90% taste and maybe 10% better code on some architecture.
> > So just pick what you prefer.
> >
> > Jörn
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Cell: 613-276-1645
