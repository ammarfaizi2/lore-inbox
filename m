Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVCCWPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVCCWPe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVCCWOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:14:10 -0500
Received: from tiere.net.avaya.com ([198.152.12.100]:47551 "EHLO
	tiere.net.avaya.com") by vger.kernel.org with ESMTP id S262653AbVCCWIZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:08:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: TTY driver race condition in 2.4 kernels?
Date: Thu, 3 Mar 2005 15:05:35 -0700
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC071DEAB3@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: TTY driver race condition in 2.4 kernels?
Thread-Index: AcUgPTXObvUFBAgcSm6Qlc/G9f7zRQ==
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moving this back to LKML from a private e-mail thread between Alan,
Marcelo and I...

Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com

On Thu, Mar 03, 2005 at 10:58:46AM -0700, Davda, Bhavesh P (Bhavesh)
wrote:
> > -----Original Message-----
> > From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> > Sent: Thursday, March 03, 2005 5:06 AM
> > To: Davda, Bhavesh P (Bhavesh)
> > Cc: Marcelo Tosatti
> > Subject: RE: TTY driver race condition in 2.4 kernels?
> > 
> > 
> > On Mer, 2005-03-02 at 23:18, Davda, Bhavesh P (Bhavesh) wrote:
> > > But you see, lcp-echo *was* configured for PPP, and that
> > doesn't seem
> > > to be the issue here. The issue is that both PPP peers have
> > negotiated
> > > to shut down the logical link, but the far end is not letting go 
> > > of
> > > the physical link (i.e. carrier), and the near end (linux) 
> > pppd *is*
> > > trying to do the right thing before exiting. It was in an
> > ioctl() to
> > > reset the line discipline back to N_TTY from PPP, when it
> > gets blocked
> > > on tty_wait_until_sent().
> > > 
> > > One could argue that pppd needs to be fixed to set a timer
> > so that a
> > > signal can wake it up from tty_wait_until_sent(), but what
> > about other
> > > TTY users?
> > 
> > Now I understand what is going on. I'll have a think about
> > that. What state is the flow control in at this point ?
> > 
> 
> Forgive me for persisting, but I don't think flow control makes a 
> difference in getting into this state. Besides, there is no such thing

> as hardware flow control for USB modem devices, since there is no way 
> to assert RTS/CTS on USB. What we are seeing with the near-end modem 
> NAK'ing USB frames back to the host controller is its way of doing 
> hardware flow control.
> 
> Thank you for applying your invaluable grey cells to this problem! I 
> really appreciate it!
> 
> BTW, should this thread go out to a wider forum? Nobody on LKML seemed

> to care or know enough to respond...

Please move it to lkml. It is an important issue.  

I sincerely dont have anything near a clue about TTY drivers/serial line
communication, so I can't help much.

Glad Alan is taking time to look into this!

------------------------------------------------------------------------
------------------------------------------------------

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Wednesday, March 02, 2005 3:22 PM
> To: Davda, Bhavesh P (Bhavesh)
> Cc: Marcelo Tosatti
> Subject: RE: TTY driver race condition in 2.4 kernels?
> 
> 
> > Yes, when either the near end or far end drops carrier
> (e.g. physical
> > disconnect of phone line), the session does go away. But
> how is this
> > fine? The PPP session was supposed to be dropped, but due
> to some bug
> > in the far end connection software (which can be any
> software on any
> > O/S), the far end didn't drop carrier, and we got into this state.
> 
> Which is expected behaviour. In cases where you want the
> session to do its own dead link detection you enable PPP keepalive.
> 
> 

But you see, lcp-echo *was* configured for PPP, and that doesn't seem to
be the issue here. The issue is that both PPP peers have negotiated to
shut down the logical link, but the far end is not letting go of the
physical link (i.e. carrier), and the near end (linux) pppd *is* trying
to do the right thing before exiting. It was in an ioctl() to reset the
line discipline back to N_TTY from PPP, when it gets blocked on
tty_wait_until_sent().

One could argue that pppd needs to be fixed to set a timer so that a
signal can wake it up from tty_wait_until_sent(), but what about other
TTY users?

Thanks

- Bhavesh

------------------------------------------------------------------------
------------------------------------------------------

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Wednesday, March 02, 2005 10:25 AM
> To: Davda, Bhavesh P (Bhavesh)
> Cc: Marcelo Tosatti
> Subject: RE: TTY driver race condition in 2.4 kernels?
> 
> 
> On Mer, 2005-03-02 at 17:05, Davda, Bhavesh P (Bhavesh) wrote:
> > The USB spec says nothing about timeouts for NAKs, and as a result,
> > the TD stays active on the USB bus, getting NAKs from the modem for 
> > eternity. I'm not sure what other physical layer protocols 
> say about
> > this.
> 
> With normal serial physical layer:
> 
> If flow control is asserted then flow control will stop the
> data and the session will hang until the data can be sent. If 
> there is now flow control then data is lost.
> 
> > Does this argue for some kind of a timed wait rather than a
> > schedule_timeout(MAX_SCHEDULE_TIMEOUT), and a return of 
> ETIMEDOUT or
> > ETIME if it times out?
> 
> When the carrier is dropped does the session then go away ?
> If it does then it seems fine, if not then I'd say it is a 
> USB serial bug
> 
> 

Yes, when either the near end or far end drops carrier (e.g. physical
disconnect of phone line), the session does go away. But how is this
fine? The PPP session was supposed to be dropped, but due to some bug in
the far end connection software (which can be any software on any O/S),
the far end didn't drop carrier, and we got into this state.

Thanks

- Bhavesh

------------------------------------------------------------------------
------------------------------------------------------

Marcelo,

Thank you very much for following up on this old posting!

On further investigation, here is what I have determined:

If the device underlying the tty is a modem (USB, serial, whatever), and
the far end of the connection doesn't let go of the carrier (DCD is up),
the modem's internal buffer fills up with data to send out, and starts
NAKing requests to the near-end host. In the USB modem case, this is in
the form of NAK TDs to the USB host-controller (UHCI, OHCI, whatever).

The USB spec says nothing about timeouts for NAKs, and as a result, the
TD stays active on the USB bus, getting NAKs from the modem for
eternity. I'm not sure what other physical layer protocols say about
this.

So the pppd task, blocked on tty->write_wait in tty_wait_until_sent(),
is never woken up since the outstanding bytes (55 in my case) could
never be sent to the modem by the ACM driver, and ACM's write completion
bottom-half never gets a chance to run and wake up tty->write_wait (and
therefore pppd).

Does this argue for some kind of a timed wait rather than a
schedule_timeout(MAX_SCHEDULE_TIMEOUT), and a return of ETIMEDOUT or
ETIME if it times out?

Thanks

- Bhavesh


Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234, U.S.A. |
Voice/Fax: (303) 538-4438 | bhavesh@avaya.com



-----Original Message-----
From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com] 
Sent: Wednesday, March 02, 2005 5:17 AM
To: Davda, Bhavesh P (Bhavesh); Alan Cox
Subject: Re: TTY driver race condition in 2.4 kernels?



Alan, 

Do you have any comments on this, pretty please?

On Wed, Feb 16, 2005 at 02:26:14PM -0700, Davda, Bhavesh P (Bhavesh)
wrote:
> Since my mail about a potential race condition in the TTY layer was
> ignored, I'm reposting it to grab peoples attention to this issue we 
> are seeing with real customers of Avaya's large real-time 
> priority-preemption telecommunications systems using USB modems for 
> PPP access.
> 
> In the 2.4 kernels (we're using 2.4.20, but this applies universally),
> is there a race window when a wake_up() of the tty->write_wait queue 
> from the underlying tty_driver can be lost in la-la-land, while a task

> is sleeping on it from tty_wait_until_sent() ?
> 
> I am seeing something similar. I have the "pppd" daemon in the
> TASK_INTERRUPTIBLE state stuck in tty_wait_until_sent() [determined 
> from wchan] as a result of its ioctl(fd, TIOCSETD, [N_TTY]) call while

> about to exit.
> 
> A debug module I wrote is showing that the tty->write_wait queue is
> empty. As a result, *nothing* will wake up pppd from its 
> TASK_INTERRUPTIBLE state.
> 
> How could that be? Just to show that I've done my homework, attached
> is my analysis of the issue.
> 
> I've seen references to race conditions in the changing of
> line-disciplines in postings by Alan Cox, but none of those references

> seems to explain what I am seeing.
> 
> Any insight would be greatly appreciated!
> 
> Thanks
> - Bhavesh
> 
> Analysis:
> 
> pppd: 
>    Calls ioctl(modemfd [/dev/usb/ttyACM0], TIOCSETD, (N_TTY)) 
>    In the kernel: 
>         tty_ioctl() calls tty_wait_until_sent(tty, 0) 
>         tty_wait_until_sent(tty, 0) 
>                 checks tty->driver.chars_in_buffer func ptr. If true, 
>                 Adds pppd to the tty->write_wait wait queue 
>                 Calls tty->driver.chars_in_buffer(tty). If true, 
>                         Translates to acm_tty_chars_in_buffer() 
>                         Returns 0 if acm->writeurb.status !=
> EINPROGRESS
> 
>                         Returns -EINVAL if !ACM_READY() 
>                         Returns acm->writeurb.transfer_buffer_length
if 
>                                 acm->writeurb.status==EINPROGRESS 
>                 Calls schedule_timeout(MAX_SCHEDULE_TIMEOUT)
> 
> 
>    To wake up pppd from schedule_timeout(MAX_SCHEDULE_TIMEOUT), 
> 	someone has to wake_up the tty->write_wait wait queue 
>    One candidate to do so is acm_softint() 
>    acm_softint() is called in bottom-half of acm_write_bulk() 
>    acm_write_bulk() is called as a completion routine for the write
URB 
>       Most likely happens in interrupt context, as the outstanding 
>       UHCI TD is completed. That's why it queues a IMMEDIATE_BH task 
>       to do acm_softint()
> 
> 
> POTENTIALS FOR RACE CONDITION:
> Another task does a write() on /dev/usb/ttyACM0 
>   Translates to acm_tty_write() 
>      acm->writeurb.tranfer_buffer_length = count passed in 
>      usb_submit_urb(&acm->writeurb) 
>         UHCI driver writes TD to USB controller
> If pppd does its ioctl(TIOCSETD) *after* usb_submit_urb() from other
> task, then its tty_wait_until_sent(tty, 0) routine will get a non-zero
> acm_tty_chars_in_buffer(). By that time, pppd has added itself to the
> tty->write_wait queue. So on completion of the TD/URB, acm_softint()
> *should* wake up pppd correctly
> 
> What happens if the TD completion interrupt (and hence the call to
> acm_write_bulk()) comes in right before pppd calls
> schedule_timeout(MAX_SCHEULE_TIMEOUT) ?
> It queues an IMMEDIATE_BH task to do acm_softint(), which won't be 
> executed until *after* the schedule_timeout() call from pppd (*I 
> THINK*, due to the non-preemptible nature of the 2.4.20 kernel). 
> acm_softint()
> *should* be 
> executed by the ksoftirqd kernel thread, which runs *after* pppd has
> called schedule_timeout(). So the wake-up of tty->write_wait *should*
> wake up pppd correctly 
> 
> What can I do to see if pppd is still on the write_wait queue for the
> tty? Write a module whose init routine will filp_open the modem tty, 
> and examine its write_wait queue and other members of tty_struct.
> 
> ORIGINAL POST:
> [http://marc.theaimsgroup.com/?l=linux-kernel&m=110850749526598&w=2]
> 
> Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
> 1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
> Voice/Fax: 303.538.4438 | bhavesh@avaya.com
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com
