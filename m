Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268130AbTBWKCH>; Sun, 23 Feb 2003 05:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268199AbTBWKBA>; Sun, 23 Feb 2003 05:01:00 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:31712 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S268189AbTBWKAZ>;
	Sun, 23 Feb 2003 05:00:25 -0500
Date: Sun, 23 Feb 2003 11:10:33 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] seq_file_howto
Message-ID: <20030223101033.GA13356@win.tue.nl>
References: <3E584805.DE41B7E9@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E584805.DE41B7E9@verizon.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 08:03:17PM -0800, Randy.Dunlap wrote:

> acme prodded me into doing this a few weeks (or months?) ago.
> It still needs some additional info for using single_open()
> and single_release(), but I'd like to get some comments on it
> and then add it to linux/Documentation/filesystems/ or post it
> on the web somewhere, like kernelnewbies.org.
> 
> Comments, corrections?

By some coincidence I also wrote some text recently.
Take whatever you want from the below.
(For example, this mentions the use of private_data.)

Andries

<sect2>seqfiles<p>
Some infrastructure exists for producing generated proc files
that are larger than a single page. The call
<verb>
        create_seq_entry("foo", mode, &amp;proc_foo_operations);
</verb>
will create a file <tt>/proc/foo</tt> with given mode
sich that opening it yields a file with <tt>proc_foo_operations</tt>
as struct file_operations. Typically one has something like
<verb>
static struct file_operations proc_foo_operations = {
        .open           = foo_open,
        .read           = seq_read,
        .llseek         = seq_lseek,
        .release        = seq_release,
};
</verb>
where <tt>foo_open</tt> is defined as
<verb>
static int foo_open(struct inode *inode, struct file *file)
{
        return seq_open(file, &amp;foo_op);
}
</verb>
and <tt>foo_op</tt> is a <tt>struct seq_operations</tt>:
<verb>
struct seq_operations {
        void * (*start) (struct seq_file *m, loff_t *pos);
        void (*stop) (struct seq_file *m, void *v);
        void * (*next) (struct seq_file *m, void *v, loff_t *pos);
        int (*show) (struct seq_file *m, void *v);
};
</verb>
<p>
The routines <tt>seq_open()</tt> etc. are defined in <tt>seq_file.c</tt>.
Here <tt>seq_open()</tt> initializes a <tt>struct seq_file</tt> and
attaches it to the <tt>private_data</tt> field of the file structure:
<verb>
struct seq_file {
        char *buf;
        size_t size;
        size_t from;
        size_t count;
        loff_t index;
        struct semaphore sem;
        struct seq_operations *op;
        void *private;
};
</verb>
(Use a buffer <tt>buf</tt> of size <tt>size</tt>. It still contains
<tt>count</tt> unread bytes, starting from buf offset <tt>from</tt>.
We return a sequence of items, and <tt>index</tt> is the current
serial number. To get a new item, call <tt>op->start()</tt>
followed by <tt>op->show()</tt>, then a number of times
<tt>op->next()</tt> followed by <tt>op->show</tt>, as long as more items
fit in the user-supplied buffer, and finally <tt>op->stop()</tt>.
Thus, the start routine can get locks or down semaphores, and the
stop routine can unlock or up them again.)
