Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTKQFsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 00:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbTKQFsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 00:48:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24267 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263330AbTKQFsV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 00:48:21 -0500
Date: Mon, 17 Nov 2003 05:48:20 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Harald Welte <laforge@netfilter.org>, linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031117054820.GT24159@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0311152135370.743-100000@einstein.homenet> <Pine.LNX.4.44.0311160717250.765-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311160717250.765-100000@einstein.homenet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 16, 2003 at 07:27:23AM +0000, Tigran Aivazian wrote:
> Hi Al,
> 
> I remembered the other two areas where, maybe, seq API can be slightly 
> improved:
> 
> a) no "THIS_MODULE" style module refcounting, so I had to do manual 
> MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT in ->open/release. I am aware of the 
> deficiencies of this approach, of course (it's been discussed too many 
> times in the last several years).

	You don't need to do that.  Look, these ->open() and ->release()
are not some new methods - they are ->open() and ->release() of your
struct file.  The fact that they happen to call functions from seq_file.c
doesn't change anything - they are struct file methods, sitting in some
instance of struct file_operations.  And just as with any such instance,
you have ->owner in struct file_operations.  Which will be honoured by
open(2) - just as with any other file.

	IOW, there is no need for any special rmmod protection of iterator.
Normal protection of file methods will be enough - after all, even if
iterator is not in the same module, the code in our ->open() directly
refers to it.  I.e. we have a direct dependency and as long as module
where our file_operations are is there, the module with our iterators
will stay around.
 
> b) no way to reset the 'offset' to 0 when the ->next() detects that it is
> back at the head of linked list, i.e. when it should return NULL. It's OK

Let me get it straight - you want an infinite file, with no EOF anywhere
and contents more or less repeating itself?  _And_ you want a working
lseek() on that?
