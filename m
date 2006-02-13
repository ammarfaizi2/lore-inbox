Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751727AbWBMMHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbWBMMHc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWBMMHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:07:31 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:49395 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751727AbWBMMHb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:07:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GTUiXupA3rBWAzn24rK+bjC5ta1U1MLBlHHA5N3TWMD4hpIO4AJfmB2bu2s3YBSV6i1AoBby3jphMaimIlwX21Av0Z/BukznWa5RlhuyKBZmAiBexefbGoneNx7Gmo3VYvQz+VeAAFPjQ07xyI28cLv1QFGBxSxF5vxt7+J1vT4=
Message-ID: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
Date: Mon, 13 Feb 2006 13:07:30 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
In-Reply-To: <43F06220.nailKUS5D8SL2@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060208162828.GA17534@voodoo>
	 <20060210114721.GB20093@merlin.emma.line.org>
	 <43EC887B.nailISDGC9CP5@burner>
	 <200602090757.13767.dhazelton@enter.net>
	 <43EC8F22.nailISDL17DJF@burner>
	 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
	 <43F06220.nailKUS5D8SL2@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> jerome lacoste <jerome.lacoste@gmail.com> wrote:
[...]
> > My understanding of that is you say to not use dev=/dev/sgc because it
> > isn't stable. Now that you've said that bus,tgt,lun is not stable on
> > Linux (because of a "Linux bug") why is the b,t,l scheme preferred
> > over the /dev/sg* one ?
>
> b,t,l _is_ stable as long as the OS does a reasonable and orthogonal work.
>
> This was true until ~ 2001, when Linux introduced unstable USB handling.
> Note that this fact is not a failure from libscg but from Linux.

This is true if you assume that "stable b,t,l" was an advertised Linux
functionality.
I may be wrong, but I don't think that this was ever the case. It
might just have been a side-effect of the implementation. Anyway,
point #2 is much more important, so let's focus on that:


> > 2) design question:
> >
> > - cdrecord scans then maps the device to the b,t,l scheme.
> > - the libsg uses the b,t,l ids in its interface to perform the operations
> >
> > So now, if cdrecord could have a new option called -scanbusmap that
> > displays the mapping it performs in a way that people can parse the
> > output, I think that will solve most issues.
>
> The output of cdrecord -scanbus is already parsable,

But it doesn't show the OS specific mapping.

> so what is your point?

I am aiming for a compromise.

My point is that people want to use dev=/dev/hdc in their interface,
because that's what they are used to. That's a point that I think you
cannot deny.

If you want to still keep your dev=b,t,l command line interface, just
let the users know how your mapping is done. That will allow a
cdrecord wrapper to first query the mapping, then using this mapping
information and OS specific information (e.g. links) identify the
b,t,l expected by your interface.

That way you have mostly no code change to do. And you keep your b,t,l
naming. Everybody is happy.

I've added something like:

                fprintf(stdout, "%d,%d,%d <= /dev/%s\n",
				first_free_schilly_bus, t, l, token[ID_TOKEN_SUBSYSTEM] );

in scsi-linux-ata.c and it does what I want.

WDYT?

Cheers,

Jerome
