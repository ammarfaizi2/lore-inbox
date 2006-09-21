Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWIUQrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWIUQrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 12:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWIUQq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 12:46:59 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:11973 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751326AbWIUQq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 12:46:58 -0400
Date: Thu, 21 Sep 2006 22:18:32 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: =?iso-8859-1?Q?S=E9bastien_Dugu=E9_=3Csebastien=2Edugue=40bull=2Enet?=.=?iso-8859-1?Q?=3E?=@qubit.in.ibm.com,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org, drepper@redhat.com,
       pbadari@us.ibm.com, hch@infradead.org, johnpol@2ka.mipt.ru,
       davem@davemloft.net
Subject: Re: [PATCH AIO 2/2] Add listio support
Message-ID: <20060921164831.GA13470@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20060911114152.4f67e59f@frecb000686> <450753C1.2080308@oracle.com> <20060921161002.GA31758@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921161002.GA31758@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 05:41:37PM -0700, Zach Brown wrote:
> 
> >   As io_submit already accepts an array of iocbs, as part of listio submission,
> > the user process prepends to a list of requests an empty special aiocb with
> > an aio_lio_opcode of IOCB_CMD_GROUP, filling only the aio_sigevent fields.
> 
> Hmm, overloading an iocb as the _GROUP indication doesn't make much
> sense to me, other than being an expedient way to shoe-horn the
> semantics into the existing API.  That we have to worry about multiple
> _GROUP iocbs in the array (ignoring them currently) seems like
> complexity that we shouldn't even have to consider.

I think it would just start a new lio group if it encounters another _GROUP
iocb.  (The code probably has a bug in that for LIO_WAIT only the latest group
seems to be taken into account in such a case, but that should be easy
to fix ... in fact maybe we could do the waiting using sys_io_wait, 
as suggest in which case it is no longer an issue)

> 
> Am I just missing the discussion that lead us to avoid a syscall?  It
> seems like we're getting a pretty funky API in return.

There was some discussion way back on linux-aio - we seemed to be going
back and forth between introducing new syscalls and overloading what we
have. There was another more recent discussion with Ulrich on the API
(if you look up the POSIX AIO discussion thread, you should find that one)

> 
> I guess I could also see an iocb command whose buf/bytes pointed to an
> array of iocb pointers that it should issue and wait for completion on.
>  You could call it, uh, IOCB_CMD_IO_SUBMIT :).  I'm only sort of kidding
> here :).  With a sys_io_wait_for_one_iocb() that might not be entirely
> ridiculous.  Then you could get an io_getevents() completion of a group
> instead of only being able to get a signal or waiting on sync
> completion.  It makes it less of a special case.

Hmm, it would be nice to implement a sys_io_wait for the IOCB_CMD_GROUP
iocb instead of performing the lio_wait() within io_submit. But what
should the semantics for sys_io_wait be for other (regular) iocb types
where there is no lio association (seems non-trivial to implement) ?
Should we just return -EINVAL for those cases ?

> 
> In any case, this current approach doesn't seem complete.  It doesn't
> deal with the case where canceled iocbs don't come through
> aio_complete() and so don't drop their lio_users count.
> 
> Also, it seems that the lio_submit() interface allows NULL iocb pointers
> by skipping them.  sys_io_submit() looks like it'd fault on them.  It
> sounds unpleasant to have an app allow nulls in the array and have the
> library copy and compress the members, or something.  Maybe we could fix
> up that mismatch in an API that explicitly took the sigevent struct?  Am
> I making up this problem?

The iocbs have to be built dynamically anyway by glibc, so does it
matter ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

