Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313589AbSDMOWX>; Sat, 13 Apr 2002 10:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313592AbSDMOWX>; Sat, 13 Apr 2002 10:22:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35069 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313589AbSDMOWW>; Sat, 13 Apr 2002 10:22:22 -0400
Importance: Normal
Sensitivity: 
Subject: Re: read proc entry
To: "Anthony Chee" <anthony.chee@polyu.edu.hk>
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OF5E84FACC.93B7730E-ON88256B9A.004CE05C@boulder.ibm.com>
From: "James Washer" <washer@us.ibm.com>
Date: Sat, 13 Apr 2002 07:19:18 -0700
X-MIMETrack: Serialize by Router on D03NM038/03/M/IBM(Release 5.0.9a |January 7, 2002) at
 04/13/2002 08:22:18 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First, I think you miss typed the mail you sent the group... in your call
to create_proc_read_entry, you passed "read_test_proc" as the name of the
function, yet you've declared here a function named "read_test_info"...

However, in answer to your question.

Since, in your routine, you've done NOTHING to tell the kernel that your
routine is completed transfering data to *page, the kernel will call it
again looking for more data to be transferred.


The sad thing is, the way things work, nearly all proc read functions will
be called twice, even when they signal they are done using *eof=1;
Why? Because your userland processes, in this case 'cat', will make
additional calls to read(2) UNTIL it gets zero bytes signalling
end-of-file.

A well written proc read function CAN recognize this subsequent read, and
return early, but nearly every proc read shipping with the kernel today
does NOT. They simply place the same information in the buffer at *page a
2nd time and return the same number of bytes written. However, since the
function proc_file_read(), which calls your proc read function, checks for
data BEYOND the old data, proc_file_read will return 0 upstream to the user
on this 2nd attempt.

It's a bit confusing at first.. but take a good long look at proc_file_read
().

 - jim

"Anthony Chee" <anthony.chee@polyu.edu.hk>@vger.kernel.org on 04/13/2002
06:48:31 AM

Sent by:    linux-kernel-owner@vger.kernel.org


To:    <linux-kernel@vger.kernel.org>
cc:
Subject:    read proc entry



I written the following code in a module

static struct proc_dir_entry *test_proc;
test_proc = create_proc_read_entry(test_proc, 0444, NULL, read_test_proc,
NULL);

void show_kernel_message() {
    printk("\nkernel test\n");
}

int read_test_info(char* page, char** start, off_t off, int count, int*
eof,
void* data) {
    show_kernel_message();
}

After I use "cat /proc/test_proc", it is found that there are three "kernel
test" messages
appear. Why it happened like this? I expected the message should be shown
once.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



