Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVCHNqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVCHNqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 08:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVCHNqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 08:46:13 -0500
Received: from smtp.cs.aau.dk ([130.225.194.6]:60908 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S262054AbVCHNqE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 08:46:04 -0500
From: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
Organization: Aalborg University
To: linux-kernel@vger.kernel.org
Subject: Reading large /proc entry from kernel module
Date: Tue, 8 Mar 2005 14:45:56 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503081445.56237.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I have some trouble reading a 2346 byte /proc entry from our Umbrella kernel 
module.

Proc file is created write-only and I am able to write text to the file, and 
read it from kernel space. The function reading the entry is in short this:

static int umb_proc_write(struct file *file, const char *buffer,
                          unsigned long count, void *data) {
	char *policy;
	int *lbuf;
	int i;
	
	if (count != UMB_POLICY_SIZE) {
		printk("Umbrella: Error - /proc/umbrella is of invalid size\n");
		return -EFAULT;
	}

	/* Initialization of lbuf */
	policy = kmalloc(sizeof(char)*UMB_POLICY_SIZE, GFP_ATOMIC);
	lbuf = kmalloc(count, GFP_KERNEL);
	if (!lbuf || !policy) {
		kfree(lbuf);
		kfree(policy);
		return -EFAULT;
	}
	if (copy_from_user(lbuf, buffer, count)) {
		kfree(lbuf);
		kfree(policy);
		return -EFAULT;
	}

	strcpy(policy, lbuf);
	umb_parse_proc(policy);

}


If I read byte by byte will only give the characters on every fourth index. 
E.g. reading lbuf with the string "abcd", then lbuf[0]==a and lbuf[1]==d ...
- Do anyone have an explanation for this behaviour? Making the strcpy does fix  
the problem - and the complete string is available! :-/ ...

Now that everything works, I want to write a string of excactly 2346 
characters to the /proc/umbrella file. However when I make the 
copy_from_user, I only get the first 1003 characters :-((
- Do you have a pointer to where I do this thing wrong?

What is the limit regarding the size of writing a /proc entry? (we consider 
importing binary public keys to the kernel this way in the future).


Best regards,
Kristian.

-- 
Kristian Sørensen
- The Umbrella Project  --  Security for Consumer Electronics
  http://umbrella.sourceforge.net

E-mail: ipqw@users.sf.net, Phone: +45 29723816
