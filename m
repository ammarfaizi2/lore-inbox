Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWDGRTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWDGRTI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 13:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWDGRTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 13:19:07 -0400
Received: from wproxy.gmail.com ([64.233.184.238]:11568 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964819AbWDGRTG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 13:19:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qP/MTk9wvph+vxcfP0k1vMJEtDwK7W99UoqQperpsg5BqXPKaOCiOto/Pe4QSmzv0KTazpp6qdXHfj5Tvhs/RCbqlFmHBX8IdX/a8xjlT+Dk1XDvGvB3EtqrTdhSyBCIMo18E1d2HfR7CBKKcItJ6RGAyJY0hiIJEh/m6cnElkc=
Message-ID: <4ae3c140604071019x571ce176odaef9fa54b6fcd2d@mail.gmail.com>
Date: Fri, 7 Apr 2006 13:19:05 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: How to know when file data has been flushed into disk?
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0604071236150.12420@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140604070842x537353c4s9a60706c2a2d25d9@mail.gmail.com>
	 <87slop1ix2.fsf@suzuka.mcnaught.org>
	 <4ae3c140604070904j51d1b968l2f62a1de647c0b02@mail.gmail.com>
	 <Pine.LNX.4.61.0604071236150.12420@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reply.

I think Douglas answered the third question, I guess you are trying to
answer the first two questions. Maybe I don't get your point. But my
question is:

Since ext3 will commit the transaction AFTER all data is flushed to
disk, it must know when the data flush is done. But how does ext3 know
that? Where can I find this code in ext3 module?

Maybe software has no way to know when the data is really written into
disk platters since hard drive has cache too. But software (like
flushd) should know when it finishes sending the data to hard drive. I
guess ext3 will commit transaction at that time. So the mysterious
thing to me is how ext3 get notified that data has been flushed.

Any further thoughts?

cheers,
Xin

On 4/7/06, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Fri, 7 Apr 2006, Xin Zhao wrote:
>
> > Thanks for your reply.
> >
> > That make sense. But at least ext3 needs to know when all data has
> > been flushed so that it can commit the meta data. Question is how can
> > ext3 knows that? The data flushing is done by flush daemon. There go
> > to be some way to notify ext3 that data is flushed. Where  is this
> > part of code in ext3 module?
> >
> > Xin
> >
> > On 4/7/06, Douglas McNaught <doug@mcnaught.org> wrote:
> >> "Xin Zhao" <uszhaoxin@gmail.com> writes:
> >>
> >>> 3. Does sys_close() have to  be blocked until all data and metadata
> >>> are committed? If not, sys_close() may give application an illusion
> >>> that the file is successfully written, which can cause the application
> >>> to take subsequent operation. However, data flush could be failed. In
> >>> this case, file system seems to mislead the application. Is this true?
> >>> If so, any solutions?
> >>
> >> The fsync() call is the way to make sure written data has hit the
> >> disk.  close() doesn't guarantee that.
> >>
> >> -Doug
> >>
>
> In principle, you __never__ know that the data got to the
> disk platter(s). Any database that thinks differently is
> broken by design. You need transaction processing to be
> assured that you have all the (correct) data available
> in the database. Transaction processing provides atomic
> stepping stones so that, in the event of a failure, the
> transactions can be rolled back to the last complete one
> and then restarted.
>
> The simplest example is the use of a number of journal
> files, each containing a record of the previous
> transactions and enough information to roll-back the
> database to the point at which these files were saved.
> These files are checksummed and saved in order. In the
> event of a crash, these files are read until the latest
> of the readable ones has a correct checksum. The database
> manager uses the information in the file to roll-back
> the main database to the exact content at the time the
> journal file was saved.
>
> Once the database is restarted, any previous journal
> files can be deleted as well as the bad ones that followed.
> However, the journal file that was used to restart the
> database is never deleted until it has been superseded
> by another that worked in a database restart. That way,
> there is always a way to get back to a clean database.
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
> Warning : 98.36% of all statistics are fiction, book release in April.
> _
> 
>
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
>
> Thank you.
>
