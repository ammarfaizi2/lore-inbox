Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292826AbSCDT6U>; Mon, 4 Mar 2002 14:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292835AbSCDT6M>; Mon, 4 Mar 2002 14:58:12 -0500
Received: from pc-80-195-34-57-ed.blueyonder.co.uk ([80.195.34.57]:33667 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S292805AbSCDT5v>; Mon, 4 Mar 2002 14:57:51 -0500
Date: Mon, 4 Mar 2002 19:57:23 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020304195723.J1444@redhat.com>
In-Reply-To: <phillips@bonn-fries.net> <1201480000.1015262195@tiny> <20020304180537.F1444@redhat.com> <E16hyRG-0000fO-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16hyRG-0000fO-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Mar 04, 2002 at 08:48:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 04, 2002 at 08:48:02PM +0100, Daniel Phillips wrote:
> On March 4, 2002 07:05 pm, Stephen C. Tweedie wrote:
> > Also, as soon as we have journals on external devices, this whole
> > thing changes entirely.  We still have to enforce the commit ordering
> > in the journal, but we also still need the ordering between that
> > commit and any subsequent writeback, and that obviousy can no longer
> > be achieved via ordered tags if the two writes are happening on
> > different devices.
> 
> But the bio layer can manage it, by sending a write barrier down all relevant 
> queues.  We can send a zero length write barrier command, yes?

Sort of --- there are various flush commands we can use.  However, bio
can't just submit the barriers, it needs to synchronise them, and that
means doing a global wait over all the devices until they have all
acked their barrier op.  That's expensive: you may be as well off just
using the current fs-internal synchronous commands at that point.

--Stephen
