Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbUBTV2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 16:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUBTV2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 16:28:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:8077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261399AbUBTV1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 16:27:52 -0500
Date: Fri, 20 Feb 2004 13:29:40 -0800
From: Dave Olien <dmo@osdl.org>
To: John Chatelle <johnch@medent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High read Latency test (Anticipatory I/O scheduler)
Message-ID: <20040220212940.GA25020@osdl.org>
References: <20040220202023.M9162@medent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220202023.M9162@medent.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was able to repeat Robert Love's results on a machine with
a simple IDE controller, two-processer system, with 500 meg memory,
ext2 file system, mounted with the noatime option.  I think
Robert's article also indicated he used an IDE controller for disk.

The results can be influenced a lot by your disk/controller
configuration.  RAID controllers in particular, or disks with large
TCQ may not perform as well with anticipatory scheduler.

Also, there were some changes to the read-ahead policy that
came  between 2.6.2 and 2.6.3, I think.  That has been shown
to make a measureable difference on systems here.

Try again with 2.6.3.

Also, try setting the antic_expire scheduler parameter for
the queue for your disk, and see what results you get.
That should hopefully be close to 2.4's behavior.  If it isn't,
then there's probably something more going on than just the
IO scheduler.

On Fri, Feb 20, 2004 at 03:20:22PM -0500, John Chatelle wrote:
>    I haven't seen much duplicated results regarding the Robert Love article 
> in the February 2004 Linux Journal article, also reachable in the hyperlink:
>           http://www.linuxjournal.com/article.php?sid=6931
> 
>  Although the 1st simple test: "Write starved reads" gets results comparable
> to the results reported in the Article, Our results for the 2nd test: "High 
> Read latency" delivers results opposite our expectations...
>  
> Kernel 2.6.2 Results: (Anticipatory I/O scheduler).
> 
> real    43m41.138s       Nearly 44 minutes! 2nd run similar.
> user    0m4.715s
> sys     0m11.179s
> 
> Kernel 2.4.20-28.7p21gsmp Results:
> 
> real    0m41.535s        Only 42 seconds!   2nd run similar.
> user    0m4.720s
> sys     0m15.470s
> 
> Our dmesg shows wer're running the Anticipatory scheduler when testing under
> the 2.6.2 kernel. 
> 
> The 2 shell scripts, StreamingRead.sh and WHR.sh (bash, actually), implement 
> the test:
> 
> #StreamingRead.sh       --simple 4 line shell script:
>    while true
>    do
>      cat ../data/oneGBfile >/dev/null
>    done
> 
> #WHR.sh                -- simple 2 (or 3) line shell script.
>    StreamingRead.sh &
>    time find /usr/src/linux-2.4.20-18.7  -type f -exec cat \
>      '{}' ';' > /dev/null
> 
>    I'm reading a 1G binary garbage file repeatedly while timing 
> the transversal and reading of the 2.4 Kernel source tree, just as the test 
> 2 example shows in the article.  I would think I/O anticipating the 1G 
> garbage file would be likely, where the I/O anticipation of the reading of 
> the source tree under the 'find' command would be far choppier and more 
> difficult.The 'time' command, however measures the less anticipatory and 
> choppier reads of the 'find' command!  I therefore see the results of table 
> 1 for test 2 to be very counter intuitive!  
> 
>   Has anyone else seen such divergent results compared to those reported in 
> the article?  Does anyone else see the same results with the anticipatory 
> I/O scheduler?  
> 
> 
>     
> 
> John Chatelle 
> johnch@medent.com 
> Community Computer Service 
> 15 Hulbert Street - P.O. Box 980 
> Auburn, New York  13021 
> Phone:  (315)-255-1751 
> Fax:    (315)-255-3539
> 
> 
> --
> This message and any attachments may contain information that is protected
> by law as privileged and confidential, and is transmitted for the sole use
> of the intended recipient(s). If you are not the intended recipient, you
> are hereby notified that any use, dissemination, copying or retention of
> this e-mail or the information contained herein is strictly prohibited. If
> you have received this e-mail in error, please immediately notify the
> sender by e-mail, and permanently delete this e-mail.
> 
> 
> 
> -- 
> This message has been scanned for viruses and
> dangerous content by MailScanner.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
