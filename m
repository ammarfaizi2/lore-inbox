Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282495AbRLFSkL>; Thu, 6 Dec 2001 13:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282497AbRLFSkD>; Thu, 6 Dec 2001 13:40:03 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:33428 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282418AbRLFSiq>; Thu, 6 Dec 2001 13:38:46 -0500
Message-ID: <3C0FBB34.2000303@redhat.com>
Date: Thu, 06 Dec 2001 13:38:44 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011115
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <9um58i$9no$1@penguin.transmeta.com> <E16BlnL-00080m-00@the-village.bc.nu> <9uo83q$aa7$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>In article <E16BlnL-00080m-00@the-village.bc.nu>,
>Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>
>>You still need the scsi code. There are a whole sequence of common, quite
>>complex and generic functions that the scsi layer handles (in paticular
>>error handling).
>>
>
>Well, the preliminary patches already handle _some_ common things, like
>building the proper command request for reads and writes etc, and that
>will probably continue.  We'll probably have to have all the old helpers
>for things like "this target only wants to be probed on lun 0" etc
>
Personally, I think it would be a mistake to have any of the low level 
driver know a thing about the ll_rw_blk.c request structs or bio 
structures or similar stuff.  They simply don't *need* to know those 
things.  Low level drivers need a command that can go to the drive and 
they need a sg array.  Smart hosts, aka raid controllers and the like, 
could theoretically use the higher level structs for reasonable things, 
but I won't make any assumptions about which ones could or couldn't use 
that information because I haven't looked into it.  So, making the scsi 
mid layer a helper library may be OK, but for the largest number of 
drivers, it really means that the call chain would likely look something 
like this:

blk_dev->request_fn()
    scsi_dispatch_request() // map from the major/minor to driver
        driver_queue_routine(bio *)
            Scsi_Cmnd = scsi_make_cmnd(bio *);
            send_command(cmnd); //put it in the hardware

driver_interrupt_routine()
    if (cmnd = get_errored_command()) {
        // Pick out the commands that had a transfer related error
        // and rework or error them out here
        if(retryable_error(cmnd))
            requeue_command(cmnd);
        else {
            cmnd->bio->completion_handler(cmnd->bio);
            scsi_free_command(cmnd);
        }
    }
    if (cmnd = get_completed_command()) {
        retryable = scsi_check_sense(cmnd);
        switch(retryable) {
            case TRANSIENT_ERROR:
                requeue_command(cmnd);
                break;
            case FATAL_ERROR:
            case NO_ERROR:
                cmnd->bio->completion_handler(cmnd->bio);
                scsi_free_command(cmnd);
                break;
            case BUSY:
                requeue_command_with_delay(cmnd);
                break;
            case ...
        }
    }

Personally, I don't like it.  The queueing stuff is somewhat OK (but 
requires other things to be changed to accomodate and I don't think 
those things should change), but I don't want to have to deal with 
result parsing in every driver.  Proper result parsing is huge and easy 
to get wrong.  The current code gets it wrong.  There are a few ways in 
which it could be fixed to do the right thing without disrupting the 
world.  Duplicating that in all the low level drivers will be a 
nightmare though.  I also don't like one aspect of putting the queueing 
totally in the low level drivers.  That way, all of the low level 
drivers are going to have to maintain A) delayable queues with variable 
delay times and undelay on completion semantics (my driver already has 
this, but it's been a source of pain to maintain, it would be nice if it 
didn't need it) and B) ordering requirements when multiple commands for 
a device operating in untagged mode are in the queue (this one isn't so 
hard, but getting it wrong means things like tape drives will store 
garbage when you least expect it).

Anyway, I suspect the end result would be the same either way: drivers 
would end up having control over their own flow of commands.  The only 
difference would be how that control would be achieved.  A) by changing 
the mid layer to accept more driver specific parameters (aka, even 
though MegaRAID may take up to 60 seconds to complete a normal command, 
the aic7xxx should never take more than 10 seconds, so the default 
command timeout length would be driver specific) and to honor the low 
level driver's idea of what to do on a timeout (let the low level driver 
tell the mid layer what action to take, and that should be the limit of 
the mid layers error handling "brains", performing those actions).  Or 
B) removing the mid layer from the picture all together (as much as 
possible anyway, it (or a similar variant) will still likely be needed 
on queueing just to map from major/minor to driver unless we change the 
device allocation scheme or something) and then having the low level 
driver call into helper routines.

>
>I disagree about the error handling, though.
>
>Traditionally, the timeouts and the reset handling was handled in the
>SCSI mid-layer, and it was a complete and utter disaster.  Different
>hosts simply wanted so different behaviour that it's not even funny.
>
That's not really accurate.  It was too opaque, sure.  But for what it 
was it did a decent job.  The mid layer driver was trying to make 
generic timeout decisions without the benefit of the low level driver's 
knowledge of the current bus state.  For example, 20 commands may time 
out at once, but in reality, only one of those commands is probably 
holding up the SCSI bus.  The low level drivers can (usually) look at 
their card to see which command is *really* the hold up.  Then, they 
could have all the other commands simply put back to sleep without doing 
anything and take appropriate action against the holdup command.  The 
current mid layer (at least in the old error handling) couldn't do that. 
 The new_eh code attempts to allow drivers to tell them these things by 
use of the strategy function.  In reality, that's all you need.  That's 
the driver's ability to tell the mid layer *how* to proceed on any given 
command.

>
>Timeouts for different commands were so different that people ended up
>making most timeouts so long that they no longer made sense for other
>commands etc.
>
Not accurate here either.  For most commands across all controllers, 
timeouts are pretty uniform (the timeout to read a CD-ROM for instance 
is pretty constant).  The timeouts *only* started to vary when you ran 
across smart RAID controllers that were doing too much work rebuilding 
things and didn't respond to your requests in a timely fashion.  And 
that only applys to their logical drives.  It would be pretty easy to 
just allow disk timeouts to be adjusted on a disk by disk basis to a 
reasonable default for that controller and solve this problem.

>
>Other device drivers have been able to handle timeouts and errors on
>their own before, and have _not_ had the kinds of horrendous problems
>that the SCSI layer has had.
>
If you use the new eh strategy function (or so I understand it, if I'm 
wrong here then I'll take the time to *make* myself right by changing 
the code), then you are essentially allowing your driver to take control 
of *what* happens, and the mid layer timeout code becomes nothing more 
than a glorified timer creation, monitoring, and teardown framework that 
happens to be plugged into the queueing and completion framework so it 
can notice new commands and when old commands are done.  Nothing more. 
 And that's all a SCSI driver that wants to do its own thing really 
needs.  Done properly, this could be a "good" thing.  Done poorly, 
everyone will hate it.  But, the ability is there to make your driver do 
what you want with the strategy call in.

>
>We'll see what the details will end up being, but I personally think
>that it is a major mistake to try to have generic error handling.  The
>only true generic thing is "this request finished successfully / with an
>error", and _no_ high-level retries etc. It's up to the driver to decide
>if retries make sense.
>
Well, I disagree on this.  I think asking all those drivers to deal with 
sense data and keep up with changing standards and new sense returns on 
new devices, etc. is just asking for a lot of out of date drivers that 
do the wrong thing.  Sense parsing and decision making is *device* 
specific, not controller specific, and I don't think it has any place 
being in the controller's responsibility list.  You might as well start 
asking eth drivers to not only check checksums on packets but also 
protocol flags before passing the packet up to the IP or TCP layers and 
to perform all the TCP retrans operations in themselves instead of in 
the TCP layer.

>
>(Often retrying _doesn't_ make sense, because the firmware on the
>high-end card or disk itself may already have done retries on its own,
>and high-level error handling is nothing but a waste of time and causes
>the error notification to be even more delayed).
>
>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



