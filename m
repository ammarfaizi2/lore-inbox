Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVANBAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVANBAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVANA5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:57:52 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:11959 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S261730AbVANAy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:54:58 -0500
Message-ID: <41E7193D.2690EDF1@akamai.com>
Date: Thu, 13 Jan 2005 16:58:37 -0800
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/self/maps still not right in 2.6.10-mm3
References: <1105652592.1208.14.camel@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:

> Looks like there's another problem.  If you read /proc/self/maps with
> >4k chunks, the reads are always truncated to < 4k.  However, at those

Since m->buf starts at  4K, read truncation is expected. But the next
truncation should be at 8K, 16K and so on.  We doube the buffer size.


>
> points, it misses an entry.  If you read in smaller chunks, the results
> look good.

Yes, loosing record on truncation is bug.   We now have  no boundary
bugs in mmaps walking logic in our start, next or stop methods.

This is due to miscommunication between seq_file.c and our version
update logic.

m_show:show_maps:seq_printf()
int seq_printf(struct seq_file *m, const char *f, ...)
{
        va_list args;
        int len;

        if (m->count < m->size) {
                va_start(args, f);
                len = vsnprintf(m->buf + m->count, m->size - m->count, f, args);
                va_end(args);
                if (m->count + len < m->size) {
                        m->count += len;
                        return 0;
                }
        }
        m->count = m->size;
        return -1;
}
It reads a partial data of the last record, and m->count becomes m->size.

Now in seq_read():
       /* we need at least one record in buffer */
        while (1) {
                pos = m->index;
                p = m->op->start(m, &pos);
                err = PTR_ERR(p);
                if (!p || IS_ERR(p))
                        break;
                err = m->op->show(m, p);
                if (err)
                        break;
                if (m->count < m->size)
                        goto Fill;
                m->op->stop(m, p);
                kfree(m->buf);
                m->buf = kmalloc(m->size <<= 1, GFP_KERNEL);
                if (!m->buf)
                        goto Enomem;
                m->count = 0;
        }
        m->op->stop(m, p);
        m->count = 0;
        goto Done;
  Fill:
        /* they want more? let's try to get some more */
        while (m->count < size) {
                size_t offs = m->count;
                loff_t next = pos;
                p = m->op->next(m, p, &next);
                if (!p || IS_ERR(p)) {
                        err = PTR_ERR(p);
                        break;
                }
                err = m->op->show(m, p);
                if (err || m->count == m->size) {
                        m->count = offs;
                        break;
                }
                pos = next;
        }
        m->op->stop(m, p);

It allocates the bigger buffer(8K) on 4k exhaustion.
It does not  copy the partial record to user or to bigger
buffer and throws  it away. But that is fine,  since pos
 is not updated.  For us, it is a problem, since version
 has already been updated.

One way of fixing this problem is,  have 100 or 200
bytes of tail room in m->buf for overflows and handle
that like we had before moving to seq  files.
This would be slightly better since, we do not throw
the data.

Other solution is,  update f_version on successful
m_show,  not on m_start or m_next. Slight variation
is reset the version on failed m_show. Since this does
not involve changes in seq_file,  we go for this and
I will send you a patch.


Thanks,
Prasanna.




