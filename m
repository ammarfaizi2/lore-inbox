Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272283AbRHXRhe>; Fri, 24 Aug 2001 13:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272287AbRHXRhY>; Fri, 24 Aug 2001 13:37:24 -0400
Received: from zapfhahn.bone.twc.de ([193.158.34.194]:24590 "EHLO
	zapfhahn.bone.twc.de") by vger.kernel.org with ESMTP
	id <S272283AbRHXRhI>; Fri, 24 Aug 2001 13:37:08 -0400
Message-ID: <20010824193714.11316@space.twc.de>
Date: Fri, 24 Aug 2001 19:37:15 +0200
From: Stefan Westerfeld <stefan@space.twc.de>
To: Doug Ledford <dledford@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i810 audio doesn't work with 2.4.9
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <no.id>; from Doug Ledford on Thu, Aug 23, 2001 at 08:03:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hi!

On Thu, Aug 23, 2001 at 08:03:00PM +0000, Doug Ledford wrote:
 > So it seems that update of i810_audio.c between 2.4.6-ac1 and ac2 breaks it (at least for me).
> > But I think it still eating too much time (about 2-3% on PIII 700) when I'm not doing anything 
> > with sound but no more up to 90% as with unmodified version from 2.4.9 (maybe it's a problem
> > of artsd , I don't know)
> 
> 
> Yes, it's a problem of artsd.  Someone decided (presumably to avoid the 
> occasional pop/click from the startup or shutdown of the sound device) 
> to make artsd transmit silence over the sound card when no sounds 
> currently need played.  From my perspective, I will *NEVER* use artsd as 
> long as it does this.  [... more rant ...]

More or less recent versions of artsd either autosuspend (close the sound
device) either after hard-coded 60 seconds of inactivity, or have a command
line option

-s <seconds>        auto-suspend time in seconds

which should adress this issue.

> Furthermore, I find 
> their use of the sound API to be suboptimal, especially when they are 
> going to transmit silence all the time. [...]

Well, artsd does non-blocking sound I/O combined with select() which tells it
when to wake up and write (read) something. It usually works quite nice if the
driver is implemented correctly, that is, if it wakes up artsd if there is a
suitable amount of data to read (write) - usually a fragment is a good choice
for the driver. The use of the API has the advantage that it

 - doesn't require threads (synchronization, context switches)
 - works well with very low latencies
 - never blocks the server (i.e. the server can always accept requests from
   the net)

Common problems with some drivers appear to be:

 * GETOSPACE/GETISPACE lies about the size that can be read/written (non-fatal,
   as long as there is at least some truth in there)

 * select() does wake up too early (i.e. if either nothing at all or just a
   small amount can be read/written) - thats fatal and leads to the 90% CPU
   scenarios

(I am not subscribed to linux-kernel, so in doubt CC me).

   Cu... Stefan
-- 
  -* Stefan Westerfeld, stefan@space.twc.de (PGP!), Hamburg/Germany
     KDE Developer, project infos at http://space.twc.de/~stefan/kde *-         
