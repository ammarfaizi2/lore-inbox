Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266942AbRG1Qwz>; Sat, 28 Jul 2001 12:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266723AbRG1Qwp>; Sat, 28 Jul 2001 12:52:45 -0400
Received: from egghead.curl.com ([216.230.83.4]:28932 "HELO egghead.curl.com")
	by vger.kernel.org with SMTP id <S266942AbRG1Qw0>;
	Sat, 28 Jul 2001 12:52:26 -0400
From: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <E15QAon-00061p-00@the-village.bc.nu>
Date: 28 Jul 2001 12:46:51 -0400
In-Reply-To: <E15QAon-00061p-00@the-village.bc.nu>
Message-ID: <s5gsnfh80hw.fsf@egghead.curl.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Also if you write metadata first then you risk delivering email to
> the wrong person instead.

The MTAs do this:

    Open temp file
    Write to temp file
    fsync() temp file
    rename() temp file into mail spool
    indicate success to remote MTA

As long as rename() does not return until the metadata are committed,
this should be a reliable delivery mechanism.  After a crash, you
might end up with the temp file still there, or with the file having a
link count of two (temp file and spool file).  But you can clean up
all of this at boot time; if the temp file is gone and the spool file
is present, then the transaction was completed.

(Yes, you might not have returned the success code to the remote MTA,
but that just means you might do a double delivery.  That is an
acceptable failure mode; corrupting, losing, or misdirecting mail is
not.)

How does this scheme "risk delivering mail to the wrong person
instead"?

If you have metadata journalling, all you need for this algorithm to
work is to have rename() write to the journal before returning.  Is
this true for any of the current journalling file systems on Linux?

 - Pat
