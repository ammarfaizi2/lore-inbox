Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWAISs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWAISs5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWAISs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:48:57 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:14454 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030248AbWAISs4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:48:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eAh4gDCekPSakVv8WdvKj/Y9xBRverNqYECRXGZeZVy3U5fAlEA2lrxz5YWkI/veuONYIqKiGsYN9L6AfvrMfpusN/EewK2MalCOU8YY6HbV7NTAA/cmmVqRremhrXIt4WoW/wBe/sJtpunahA+hHcqins8K65ALGxpYFhlnr9o=
Message-ID: <9a8748490601091048x46716e25u2fe2ebe9b5fbc9bb@mail.gmail.com>
Date: Mon, 9 Jan 2006 19:48:54 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-mm2
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601091819160.14800@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060107052221.61d0b600.akpm@osdl.org>
	 <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com>
	 <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com>
	 <20060109175748.GD25102@redhat.com>
	 <9a8748490601091001y74fba5q2cd7e08a324701c3@mail.gmail.com>
	 <Pine.LNX.4.61.0601091819160.14800@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Hugh Dickins <hugh@veritas.com> wrote:
> On Mon, 9 Jan 2006, Jesper Juhl wrote:
> > On 1/9/06, Dave Jones <davej@redhat.com> wrote:
> > > On Mon, Jan 09, 2006 at 06:47:01PM +0100, Jesper Juhl wrote:
> > >
> > >  > Here's what bad_page printed for me :
> > >  >
> > >  > Bad page state in process 'kded'
> > >  > [<c0103e77>] dump_stack+0x17/0x20
> > >  > [<c0148999>] bad_page+0x69/0x160
> > >
> > > Odd, there should be more state between the 'Bad page'
> > > and the backtrace.
> > >
> > >     printk(KERN_EMERG "Bad page state in process '%s'\n"
> > >                 "page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
> > >                 "Trying to fix it up, but a reboot is needed\n"
> > >
> > > Did you aggressively trim that, or did it for some
> > > reason not get printed ?
> > >
> >
> > I did not trim that.
> >
> > All I did was add
> >
> >  printk(KERN_EMERG "we hit bad page, looping forever\n");
> >  while (1) {
> >     mdelay(1000);
> >  }
> >
> > to the end of bad_page()
>
> I'm afraid someone has recently "tidied up" bad_page, and missed out
> the most interesting KERN_EMERG of all.  No promises that this will
> actually help us more than the backtrace you've sent, but please give
> it another go with patch below applied.  Andrew, please pass along...
>
>
> Restore KERN_EMERG to each line printed by bad_page.
>
Ok, with that patch the page, flags, mapping, mapcount & count
information prints again.
I get the exact same backtrace as before though, but a slightly
different hexdump :

Bad page state in process 'kded'
page:c1e75400 flags:0x00000000 mapping:00000000 mapcount:1 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
[<c0103e77>] dump_stack+0x17/0x20
[<c0148999>] bad_page+0x69/0x160
[<c0148e92>] __free_pages_ok+0xa2/0x120
[<c0149c7f>] __free_pages+0x2f/0x60
[<c02acb63>] sg_page_free+0x23/0x30
[<c02abdb3>] sg_remove_scat+0x63/0xe0
[<c02ac80d>] __sg_remove_sfp+0x4d/0xc0
[<c02ac927>] sg_remove_sfp+0xa7/0x120
[<c02a8b39>] sg_release+0x49/0xc0
[<c0166827>] __fput+0x167/0x1b0
[<c01666ab>] fput+0x3b/0x50
[<c0164efc>] filp_close+0x3c/0x80
[<c0164fa9>] sys_close+0x69/0x90
[<c0103009>] syscall_call+0x7/0xb
Hexdump:
000: ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00
010: d0 53 e7 c1 d0 53 e7 c1 ff ff ff ff 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
040: 00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00
050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

One more note: the first time I booted the kernel with this patch X
failed to start. It started and blacked out the screen, at that point
the system hung, but not completely, I could still switch tty with
ctrl+alt+f? but all tty's I switched to were also completely black
with just a cursor in the top left corner. The system never recovered
from this state and I was forced to press the reset button.
The second time it booted up fine and launched kdm as usual to let me
log in and upon logging in it crashed as expected while launching KDE
(at that point I had switched over to tty1 and captured the crash dump
you see above).
So, it seems to me that we may have more than one bug.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
