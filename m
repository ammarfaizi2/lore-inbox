Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVBIAOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVBIAOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 19:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVBIAOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 19:14:33 -0500
Received: from nn7.excitenetwork.com ([207.159.120.61]:2145 "EHLO excite.com")
	by vger.kernel.org with ESMTP id S261709AbVBIAO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 19:14:28 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Problem in accessing executable files
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = 55b63a5ebc1ab3ff821d77785eb5b925
Reply-To: vintya@excite.com
From: "Vineet Joglekar" <vintya@excite.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-c-programming@vger.kernel.org
Message-Id: <20050209001427.61C438AF24@xprdmailfe2.nwk.excite.com>
Date: Tue,  8 Feb 2005 19:14:27 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

1 more interesting observation regarding my executable file problem.

If I copy an executable say "prac" from ext2 fs to my encrypted fs as prac1, prac1 doesnt run on the encrypted fs. but, if I make another copy, from prac1 to normal ext2 fs, as prac2, then the prac2 executes properly on normal file system. that means my encryption, decryption functions are getting executed properly while using that executable as normal file to read and write, but something else is happening when I try to execute it. I am failing to understand what am I missing.

Vineet

 --- On Sun 02/06, Vineet Joglekar < vintya@excite.com > wrote:
From: Vineet Joglekar [mailto: vintya@excite.com]
To: jtwilliams@vt.edu, linux-kernel@vger.kernel.org
     Cc: linux-c-programming@vger.kernel.org
Date: Sun,  6 Feb 2005 17:41:01 -0500 (EST)
Subject: Re: Problem in accessing executable files

<br>Hi John,<br><br>Thanks for suggesting the single / few bytes encryption test. I tried doing that, but in vain. Maybe I am going wrong somewhere else.<br><br>I will briefly tell the functions I have written and the sequence if I am doing any mistake in the logic, please let me know.<br>In file.c I have added the info about the functions my_generic_file_read and my_generic_file_write in ext2_file_operations.<br><br>For decrypting, the sequence is:<br>my_generic_file_read ---> my_do_generic_file_read ---> my_file_read_actor ---> my_decrypt_data<br><br>I have not made any changes in my_generic_file_read  and my_do_generic_file_read. In the function my_file_read_actor, I copy the page to my buffer (1 page - allocated at the time of mounting) I decrypt that buffer and pass it to the __copy_to_user() function.<br><br>for encrypting, the sequence is:<br>my_generic_file_write ---> my_encrypt_data<br><br>In function my_generic_file_write, between functions __copy_from_user() and commit_write(), I am calling my_encrypt_data() by passing address of the page that is passed to __copy_from_user()<br><br>My encrypt / decrypt routine is very basic at this time - just xoring every byte of the page as:<br>*to = *to ^ 0xff; *to++;<br><br>If I change my encrypt/decrypt routines to encrypt / decrypt just first or last byte of the page, then I get a different error saying the file is not executable - when I try to execute it. I thought there might be a problem with executable header, but I guess when I encrypt last byte of the page, header should have been bypassed.<br><br>Is it something like, for executables, the data is refered in some other functions - that is, before do_generic_file_read geting called?<br><br>Thanks and regards,<br><br>Vineet<br><br> --- On Tue 02/01, John T. Williams < jtwilliams@vt.edu > wrote:<br>From: John T. Williams [mailto: jtwilliams@vt.edu]<br>To: vintya@excite.com, linux-kernel@vger.kernel.org<br>     Cc: linux-c-programming@vger.kernel.org<br>Date: Tue, 1 Feb 2005 10:37:30 -0500<br>Subject:!
  Re: Pro
blem in accessing executable files<br><br>This is just a thought.<br><br>Text files are better able to handle small faults. ie an extra space or<br>characters or even an unreadable piece of data might not cause the file to<br>become unreadable by most text editors.  Binary files aren't as flexible.<br>Every bit could be an instruction to the processor and might cause a seg<br>fault.<br><br>Just to test the theory, I would start by making the encrypt decrypt<br>function only effect the first byte.  If doing this doesn't cause a seg<br>fault, I would recheck my decrypt encrypt algorithm to make sure it doesn't<br>pad or expand at any point. maybe use them on a regular file and the an<br>md5sum on the file before and after, just to make extra sure.<br><br><br>----- Original Message ----- <br>From: "Vineet Joglekar" <vintya@excite.com><br>To: <linux-kernel@vger.kernel.org><br>Cc: <linux-c-programming@vger.kernel.org><br>Sent: Tuesday, February 01, 2005 8:58 AM<br>Subject: Problem in accessing executable files<br><br><br>><br>> Hi all,<br>><br>> I am trying to add some cryptographic functionality to ext2 file system<br>for my masters project. I am working with kernel 2.4.21<br>><br>> since the routines do_generic_file_read and do_generic_file_write are used<br>in reading and writing, I am decrypting and encrypting the data in the resp.<br>functions. This is working fine for regular data files. If I try to copy /<br>execute executable files, I am getting segmentation fault. In kernel<br>messages, I see same functions (read and write) getting called for the<br>executables also. If I comment encrypt/decrypt functions, its working fine.<br>><br>> Now since it is working for regular text files, I suppose there is not a<br>problem in my encrypt/decrypt routines, then what might be going wrong?<br>><br>> Thanks and regards,<br>><br>> Vineet<br>><br>> _______________________________________________<br>> Join Excite! - http://www.excite.com<br>> The most personalized portal on the Web!<br>> -<br>> To unsubscribe from !
 this lis
t:
  send the line "unsubscribe<br>linux-c-programming" in<br>> the body of a message to majordomo@vger.kernel.org<br>> More majordomo info at  http://vger.kernel.org/majordomo-info.html<br><br><br><br><br>_______________________________________________<br>Join Excite! - http://www.excite.com<br>The most personalized portal on the Web!<br>-<br>To unsubscribe from this list: send the line "unsubscribe linux-c-programming" in<br>the body of a message to majordomo@vger.kernel.org<br>More majordomo info at  http://vger.kernel.org/majordomo-info.html<br>

_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!
