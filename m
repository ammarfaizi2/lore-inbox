Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVBFWlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVBFWlL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 17:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVBFWlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 17:41:11 -0500
Received: from nn4.excitenetwork.com ([207.159.120.58]:35906 "EHLO excite.com")
	by vger.kernel.org with ESMTP id S261247AbVBFWlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 17:41:06 -0500
To: jtwilliams@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: Problem in accessing executable files
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = 41790ee39c7967bbf4ef314fad615410
Reply-To: vintya@excite.com
From: "Vineet Joglekar" <vintya@excite.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-c-programming@vger.kernel.org
Message-Id: <20050206224101.B1F71B6CB@xprdmailfe15.nwk.excite.com>
Date: Sun,  6 Feb 2005 17:41:01 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi John,

Thanks for suggesting the single / few bytes encryption test. I tried doing that, but in vain. Maybe I am going wrong somewhere else.

I will briefly tell the functions I have written and the sequence if I am doing any mistake in the logic, please let me know.
In file.c I have added the info about the functions my_generic_file_read and my_generic_file_write in ext2_file_operations.

For decrypting, the sequence is:
my_generic_file_read ---> my_do_generic_file_read ---> my_file_read_actor ---> my_decrypt_data

I have not made any changes in my_generic_file_read  and my_do_generic_file_read. In the function my_file_read_actor, I copy the page to my buffer (1 page - allocated at the time of mounting) I decrypt that buffer and pass it to the __copy_to_user() function.

for encrypting, the sequence is:
my_generic_file_write ---> my_encrypt_data

In function my_generic_file_write, between functions __copy_from_user() and commit_write(), I am calling my_encrypt_data() by passing address of the page that is passed to __copy_from_user()

My encrypt / decrypt routine is very basic at this time - just xoring every byte of the page as:
*to = *to ^ 0xff; *to++;

If I change my encrypt/decrypt routines to encrypt / decrypt just first or last byte of the page, then I get a different error saying the file is not executable - when I try to execute it. I thought there might be a problem with executable header, but I guess when I encrypt last byte of the page, header should have been bypassed.

Is it something like, for executables, the data is refered in some other functions - that is, before do_generic_file_read geting called?

Thanks and regards,

Vineet

 --- On Tue 02/01, John T. Williams < jtwilliams@vt.edu > wrote:
From: John T. Williams [mailto: jtwilliams@vt.edu]
To: vintya@excite.com, linux-kernel@vger.kernel.org
     Cc: linux-c-programming@vger.kernel.org
Date: Tue, 1 Feb 2005 10:37:30 -0500
Subject: Re: Problem in accessing executable files

This is just a thought.<br><br>Text files are better able to handle small faults. ie an extra space or<br>characters or even an unreadable piece of data might not cause the file to<br>become unreadable by most text editors.  Binary files aren't as flexible.<br>Every bit could be an instruction to the processor and might cause a seg<br>fault.<br><br>Just to test the theory, I would start by making the encrypt decrypt<br>function only effect the first byte.  If doing this doesn't cause a seg<br>fault, I would recheck my decrypt encrypt algorithm to make sure it doesn't<br>pad or expand at any point. maybe use them on a regular file and the an<br>md5sum on the file before and after, just to make extra sure.<br><br><br>----- Original Message ----- <br>From: "Vineet Joglekar" <vintya@excite.com><br>To: <linux-kernel@vger.kernel.org><br>Cc: <linux-c-programming@vger.kernel.org><br>Sent: Tuesday, February 01, 2005 8:58 AM<br>Subject: Problem in accessing executable files<br><br><br>><br>> Hi all,<br>><br>> I am trying to add some cryptographic functionality to ext2 file system<br>for my masters project. I am working with kernel 2.4.21<br>><br>> since the routines do_generic_file_read and do_generic_file_write are used<br>in reading and writing, I am decrypting and encrypting the data in the resp.<br>functions. This is working fine for regular data files. If I try to copy /<br>execute executable files, I am getting segmentation fault. In kernel<br>messages, I see same functions (read and write) getting called for the<br>executables also. If I comment encrypt/decrypt functions, its working fine.<br>><br>> Now since it is working for regular text files, I suppose there is not a<br>problem in my encrypt/decrypt routines, then what might be going wrong?<br>><br>> Thanks and regards,<br>><br>> Vineet<br>><br>> _______________________________________________<br>> Join Excite! - http://www.excite.com<br>> The most personalized portal on the Web!<br>> -<br>> To unsubscribe from this list: send the line "unsubscribe<br>l!
 inux-c-p
rogramming" in<br>> the body of a message to majordomo@vger.kernel.org<br>> More majordomo info at  http://vger.kernel.org/majordomo-info.html<br><br><br>

_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!
