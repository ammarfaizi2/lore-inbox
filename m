Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268023AbTBWDzZ>; Sat, 22 Feb 2003 22:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268025AbTBWDzZ>; Sat, 22 Feb 2003 22:55:25 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:39603 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S268023AbTBWDzW>; Sat, 22 Feb 2003 22:55:22 -0500
Message-ID: <3E584805.DE41B7E9@verizon.net>
Date: Sat, 22 Feb 2003 20:03:17 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.62 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] seq_file_howto
Content-Type: multipart/mixed;
 boundary="------------261C8376FF94220F5C56FF5D"
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [4.64.238.61] at Sat, 22 Feb 2003 22:05:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------261C8376FF94220F5C56FF5D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

acme prodded me into doing this a few weeks (or months?) ago.
It still needs some additional info for using single_open()
and single_release(), but I'd like to get some comments on it
and then add it to linux/Documentation/filesystems/ or post it
on the web somewhere, like kernelnewbies.org.

Comments, corrections?

Thanks,
~Randy
--------------261C8376FF94220F5C56FF5D
Content-Type: text/plain; charset=us-ascii;
 name="seq_file_howto.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="seq_file_howto.txt"

The "seq_file" interface to the /proc filesystem was introduced in
Linux 2.4.15-pre3 and Linux 2.4.13-ac8.  It provides a safer interface
to the /proc filesystem than previous procfs methods because it protects
against overflow of the output buffer.  It also provides methods for
traversing a list of kernel items and iterating on that list.
It attempts to provide facilities that are less error-prone that the
previous procfs interfaces.

Overview:  seq_file operates by using "pull" methods, pulling or asking
for data from seq_file operations methods, whereas the previous procfs
methods pushed data into output buffers.

The seq_file routines never take any locks between the ->open() and
->stop() functions, so seq_file callers are free to use anything --
spinlocks, etc.

The seq_file interface does require more data structures to be setup
to point to methods that are used during seq_file access.  These four
methods are in struct seq_operations:

struct seq_operations {
	void * (*start) (struct seq_file *m, loff_t *pos);
	void (*stop) (struct seq_file *m, void *v);
	void * (*next) (struct seq_file *m, void *v, loff_t *pos);
	int (*show) (struct seq_file *m, void *v);
};

.start: lock whatever you need to lock and return an entry by number;
sets the iterator up and returns the first element of sequence::

.start is used to initialize data for walking through a list of kernel
items.  This list can be an array, a linked list, a hash table, etc.
Its actual data type doesn't matter.

If there is any locking that needs to be done to iterate through the
kernel list, the lock(s) can be acquired in the .start method.  However,
if the .show method is very time-consuming and the .show method lends
itself to locking there, that may be a better place for it.

.stop: done with seq_file, unlock or free resources::

The .stop method is called after the .next method has nothing more to
do.  This method is used for cleanups and unlocking etc.
The .stop method is always called if the .start method was called, even
if the .start method fails, so that all cleanups can be done in .stop.

.next: returns the next element (entry) of sequence::

The .next method is the kernel item iterator.  It advances to the next
item of interest to be shown and indicates when there are no more such
items by returning NULL or an error (like -ENOMEM or -EACCES).

.show: show an entry, using seq_...() as you would use stdio functions::

The .show method is used to put data (static headings or variable
data) into the seq_file output buffer.  It uses seq_{putc, puts, printf, ...}
to format the output.


The seq_file output methods are:

/*
 * seq_putc:
 * print one character to the seq_file output buffer
 * returns 0 for success or -1 for error
 */
int seq_putc(struct seq_file *m, char c);

/*
 * seq_puts:
 * print a null-terminated string to the seq_file output buffer
 * returns 0 for success or -1 for error
 */
int seq_puts(struct seq_file *m, const char *s);

/*
 * seq_printf:
 * print a formatted string and variable data to the seq_file output buffer
 * returns 0 for success or -1 for error
 */
int seq_printf(struct seq_file *m, const char *f, ...);

/*
 *	seq_open:	initialize sequential file
 *	@file: file to initialize
 *	@op: method table describing the sequence
 *
 *	seq_open() sets @file, associating it with a sequence described
 *	by @op.  @op->start() sets the iterator up and returns the first
 *	element of sequence. @op->stop() shuts it down.  @op->next()
 *	returns the next element of sequence.  @op->show() prints element
 *	into the buffer.  In case of error ->start() and ->next() return
 *	ERR_PTR(error).  In the end of sequence they return %NULL. ->show()
 *	returns 0 in case of success and negative number in case of error.
 */
int seq_open(struct file *file, struct seq_operations *op);

/*
 *	seq_read:	->read() method for sequential files.
 *	@file, @buf, @size, @ppos: see file_operations method
 *
 *	Ready-made ->f_op->read()
 */
ssize_t seq_read(struct file *file, char *buf, size_t size, loff_t *ppos);

/*
 *	seq_lseek:	->llseek() method for sequential files.
 *	@file, @offset, @origin: see file_operations method
 *
 *	Ready-made ->f_op->llseek()
 */
loff_t seq_lseek(struct file *file, loff_t offset, int origin);

/*
 *	seq_release:	free the structures associated with sequential file.
 *	@file: file in question
 *	@inode: file->f_dentry->d_inode
 *
 *	Frees the structures associated with sequential file; can be used
 *	as ->f_op->release() if you don't have private data to destroy.
 */
int seq_release(struct inode *inode, struct file *file);

/*
 *	seq_escape: print string into buffer, escaping some characters
 *	@m:	target buffer
 *	@s:	string
 *	@esc:	set of characters that need escaping
 *
 *	Puts string into buffer, replacing each occurence of character from
 *	@esc with usual octal escape.  Returns 0 in case of success
 *	or -1 in case of overflow.
 */
int seq_escape(struct seq_file *m, const char *s, const char *esc);


If you only need a single function entry, just use single_open() and
single_release().  TBD: FIXME/MORE.

###

--------------261C8376FF94220F5C56FF5D--

