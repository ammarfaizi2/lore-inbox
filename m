Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWDGQzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWDGQzk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 12:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWDGQzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 12:55:40 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:4359 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964813AbWDGQzj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 12:55:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <4ae3c140604070904j51d1b968l2f62a1de647c0b02@mail.gmail.com>
x-originalarrivaltime: 07 Apr 2006 16:55:34.0634 (UTC) FILETIME=[167084A0:01C65A64]
Content-class: urn:content-classes:message
Subject: Re: How to know when file data has been flushed into disk?
Date: Fri, 7 Apr 2006 12:55:33 -0400
Message-ID: <Pine.LNX.4.61.0604071236150.12420@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to know when file data has been flushed into disk?
Thread-Index: AcZaZBZ615jOFKZ1TX6jZXd2aOm0bQ==
References: <4ae3c140604070842x537353c4s9a60706c2a2d25d9@mail.gmail.com> <87slop1ix2.fsf@suzuka.mcnaught.org> <4ae3c140604070904j51d1b968l2f62a1de647c0b02@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Xin Zhao" <uszhaoxin@gmail.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Apr 2006, Xin Zhao wrote:

> Thanks for your reply.
>
> That make sense. But at least ext3 needs to know when all data has
> been flushed so that it can commit the meta data. Question is how can
> ext3 knows that? The data flushing is done by flush daemon. There go
> to be some way to notify ext3 that data is flushed. Where  is this
> part of code in ext3 module?
>
> Xin
>
> On 4/7/06, Douglas McNaught <doug@mcnaught.org> wrote:
>> "Xin Zhao" <uszhaoxin@gmail.com> writes:
>>
>>> 3. Does sys_close() have to  be blocked until all data and metadata
>>> are committed? If not, sys_close() may give application an illusion
>>> that the file is successfully written, which can cause the application
>>> to take subsequent operation. However, data flush could be failed. In
>>> this case, file system seems to mislead the application. Is this true?
>>> If so, any solutions?
>>
>> The fsync() call is the way to make sure written data has hit the
>> disk.  close() doesn't guarantee that.
>>
>> -Doug
>>

In principle, you __never__ know that the data got to the
disk platter(s). Any database that thinks differently is
broken by design. You need transaction processing to be
assured that you have all the (correct) data available
in the database. Transaction processing provides atomic
stepping stones so that, in the event of a failure, the
transactions can be rolled back to the last complete one
and then restarted.

The simplest example is the use of a number of journal
files, each containing a record of the previous
transactions and enough information to roll-back the
database to the point at which these files were saved.
These files are checksummed and saved in order. In the
event of a crash, these files are read until the latest
of the readable ones has a correct checksum. The database
manager uses the information in the file to roll-back
the main database to the exact content at the time the
journal file was saved.

Once the database is restarted, any previous journal
files can be deleted as well as the bad ones that followed.
However, the journal file that was used to restart the
database is never deleted until it has been superseded
by another that worked in a database restart. That way,
there is always a way to get back to a clean database.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
