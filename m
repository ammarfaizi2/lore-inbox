Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263427AbSIPX5A>; Mon, 16 Sep 2002 19:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263433AbSIPX5A>; Mon, 16 Sep 2002 19:57:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31244 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263427AbSIPX46>;
	Mon, 16 Sep 2002 19:56:58 -0400
Message-ID: <3D8670D4.9040801@mandrakesoft.com>
Date: Mon, 16 Sep 2002 20:01:24 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: dwmw2@infradead.org, linux-kernel@vger.kernel.org, todd-lkml@osogrande.com,
       hadi@cyberus.ca, tcw@tempest.prismnet.com, netdev@oss.sgi.com,
       pfeather@cs.unm.edu
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <3D86645F.5030401@mandrakesoft.com>	<20020916.160210.70782700.davem@redhat.com>	<3D866DD5.4080207@mandrakesoft.com> <20020916.164343.128145825.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------060600040500080402020405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060600040500080402020405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
>    From: Jeff Garzik <jgarzik@mandrakesoft.com>
>    Date: Mon, 16 Sep 2002 19:48:37 -0400
> 
>    I dunno when it happened, but 2.5.x now returns EINVAL for all 
>    file->file cases.
>    
>    In 2.4.x, if sendpage is NULL, file_send_actor in mm/filemap.c faked a 
>    call to fops->write().
>    In 2.5.x, if sendpage is NULL, EINVAL is unconditionally returned.
>    
> 
> What if source and destination file and offsets match?


The same data is written out.  No deadlock.
(unless the attached test is wrong)

	Jeff



--------------060600040500080402020405
Content-Type: text/plain;
 name="sendfile-test-2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sendfile-test-2.c"

#include <sys/sendfile.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <stdio.h>

int main (int argc, char *argv[])
{
	int in, out;
	struct stat st;
	off_t off = 0;
	ssize_t rc;

	in = open("test.data", O_RDONLY);
	if (in < 0) {
		perror("test.data read");
		return 1;
	}

	fstat(in, &st);

	out = open("test.data", O_WRONLY);
	if (out < 0) {
		perror("test.data write");
		return 1;
	}

	rc = sendfile(out, in, &off, st.st_size);
	if (rc < 0) {
		perror("sendfile");
		close(in);
		unlink("out");
		close(out);
		return 1;
	}

	close(in);
	close(out);
	return 0;
}


--------------060600040500080402020405--

