Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSHUBv2>; Tue, 20 Aug 2002 21:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317642AbSHUBv2>; Tue, 20 Aug 2002 21:51:28 -0400
Received: from mail01.qualys.com ([12.162.2.5]:23264 "HELO mail01.qualys.com")
	by vger.kernel.org with SMTP id <S317641AbSHUBv1>;
	Tue, 20 Aug 2002 21:51:27 -0400
Date: Tue, 20 Aug 2002 18:00:29 -0700
From: Silvio Cesare <silvio@qualys.com>
To: linux-kernel@vger.kernel.org
Cc: silvio@qualys.com
Subject: fs/select.c [patch > to >=]
Message-ID: <20020820180029.A17387@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

fs/select.c (from 2.4.19 but present in 2.5.x also)

asmlinkage long sys_poll(struct pollfd * ufds, unsigned int nfds, long timeout)
{
        int i, j, fdcount, err;
        struct pollfd **fds;
        poll_table table, *wait;
        int nchunks, nleft;

[ skip ]

        nchunks = 0;
        nleft = nfds;
        while (nleft > POLLFD_PER_PAGE) { /* allocate complete PAGE_SIZE chunks
*/
                fds[nchunks] = (struct pollfd *)__get_free_page(GFP_KERNEL);
                if (fds[nchunks] == NULL)
                        goto out_fds;
                nchunks++;
                nleft -= POLLFD_PER_PAGE;
        }
        if (nleft) { /* allocate last PAGE_SIZE chunk, only nleft elements used
*/

why not -->

        while (nleft >= POLLFD_PER_PAGE) {

in this case we will use only nchunks in the case that this will end up
page aligned..  the current way of using only > POLLFD_PER_PAGE will
end up with nchunks, and nleft == PAGE_SIZE / sizeof(pollfd) etc..

silly optimisation by changing > to >=, but still an optimisation.. if there
is something obviously wrong with changing > to >=, ignore me since I
probably should get more sleep.. but I dont see any problem though I havent
really looked at it too much.

attachment has 1 line (1 character) patch ;-)

--
Silvio


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="poll.patch"

diff -u fs/select.c.2.4.19 fs/select.c 
--- fs/select.c.2.4.19	Tue Aug 20 17:51:48 2002
+++ fs/select.c	Tue Aug 20 17:52:15 2002
@@ -445,7 +445,7 @@
 
 	nchunks = 0;
 	nleft = nfds;
-	while (nleft > POLLFD_PER_PAGE) { /* allocate complete PAGE_SIZE chunks */
+	while (nleft >= POLLFD_PER_PAGE) { /* allocate complete PAGE_SIZE chunks */
 		fds[nchunks] = (struct pollfd *)__get_free_page(GFP_KERNEL);
 		if (fds[nchunks] == NULL)
 			goto out_fds;

--2fHTh5uZTiUOsy+g--
