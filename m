Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVAOAnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVAOAnA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVAOAnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:43:00 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:40109 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S262062AbVAOAmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:42:40 -0500
Message-ID: <41E867DE.11F4016A@akamai.com>
Date: Fri, 14 Jan 2005 16:46:22 -0800
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm3: lseek broken on /proc/self/maps
References: <1105737819.11209.9.camel@localhost>
Content-Type: multipart/mixed;
 boundary="------------BBA573ADC0953C320CC88631"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BBA573ADC0953C320CC88631
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jeremy Fitzhardinge wrote:

> lseek doesn't seem to have any effect on /proc/<pid>/maps.  It should
> either work as expected, or fail.
>

An oversight, f_version is not reset by seq_lseek as done by generic_lseek.
Please try the attached patch.


>
> I've attached a test program which uses a doubling buffer policy to try
> to read the whole buffer.  If it runs out of buffer, it simply allocates
> a new one, lseeks back to the beginning of the buffer, and tries again.
> However, the lseek seems to have no effect, because the next read
> continues from where the previous one (before the lseek) left off.
>
> Re-opening the file between each attempt works as expected.
>

Thanks a lot  for testing all the corner cases.

--------------BBA573ADC0953C320CC88631
Content-Type: text/plain; charset=us-ascii;
 name="seq_version.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="seq_version.patch"


I missed the point that seq_lseek did not reset the f_version,
like generic_lseek did, until Jeremy proved with an example.

Signed-off-by: Prasanna Meda <pmeda@akamai.com>

--- fs/seq_file.c	Fri Jan 14 23:51:27 2005
+++ fs/seq_file.c	Fri Jan 14 23:51:59 2005
@@ -117,6 +117,7 @@ ssize_t seq_read(struct file *file, char
 		if (!m->buf)
 			goto Enomem;
 		m->count = 0;
+		m->version = 0;
 	}
 	m->op->stop(m, p);
 	m->count = 0;
@@ -173,6 +174,7 @@ static int traverse(struct seq_file *m, 
 	int error = 0;
 	void *p;
 
+	m->version = 0;
 	m->index = 0;
 	m->count = m->from = 0;
 	if (!offset)
@@ -227,6 +229,7 @@ loff_t seq_lseek(struct file *file, loff
 	long long retval = -EINVAL;
 
 	down(&m->sem);
+	m->version = file->f_version;
 	switch (origin) {
 		case 1:
 			offset += file->f_pos;
@@ -240,6 +243,7 @@ loff_t seq_lseek(struct file *file, loff
 				if (retval) {
 					/* with extreme prejudice... */
 					file->f_pos = 0;
+					m->version = 0;
 					m->index = 0;
 					m->count = 0;
 				} else {
@@ -248,6 +252,7 @@ loff_t seq_lseek(struct file *file, loff
 			}
 	}
 	up(&m->sem);
+	file->f_version = m->version;
 	return retval;
 }
 EXPORT_SYMBOL(seq_lseek);

--------------BBA573ADC0953C320CC88631--

