Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270919AbRHXEXs>; Fri, 24 Aug 2001 00:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270905AbRHXEXi>; Fri, 24 Aug 2001 00:23:38 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:22035 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269777AbRHXEX1>;
	Fri, 24 Aug 2001 00:23:27 -0400
Date: Fri, 24 Aug 2001 01:23:32 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Pete Marvin King <pmking@ntsp.nec.co.jp>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: socket problem
Message-ID: <20010824012332.B1022@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Pete Marvin King <pmking@ntsp.nec.co.jp>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3B864198.9E132BFB@ntsp.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B864198.9E132BFB@ntsp.nec.co.jp>; from pmking@ntsp.nec.co.jp on Fri, Aug 24, 2001 at 11:59:21AM +0000
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 24, 2001 at 11:59:21AM +0000, Pete Marvin King escreveu:
> 
>     Is it possible to increase the maximum sockets that can be opened
> simultaneously?
> I'd like it to reach 1024, is it possible?
> 
>     I'm currently doing a stress test on postgres. we created a dummy
> client that would
> connect to it 1024 times. But is just stops at 324,
> postgres reports : " postmaster: StreamConnection: accept: Too many open
> files in system".
> 
>     I don't think the problem is not with the file descriptors. Is it
> the max num of sockets?
> or maybe the maximum number of files that can be opened?
> 
>     Any help would be greatly appreciated.

increase te max number of fds in /proc/sys/fs/file-max and in ulimit -n

[root@brinquedo /root]# cat ~acme/max_sockets.c
#include <sys/types.h>
#include <sys/socket.h>

int main(void)
{
        int nr_sockets = 0;

        while(socket(PF_INET, SOCK_STREAM, 0) > 0)
                ++nr_sockets;
        printf("nr_sockets=%d\n", nr_sockets);
        return 0;
}
[root@brinquedo /root]# ulimit -n
4096
[root@brinquedo /root]# ./max_sockets
nr_sockets=4093
[root@brinquedo /root]# ulimit -n 8192
[root@brinquedo /root]# ./max_sockets
nr_sockets=7600
[root@brinquedo /root]# ulimit -n 16384
[root@brinquedo /root]# ./max_sockets
nr_sockets=7601
[root@brinquedo /root]# cat /proc/sys/fs/file-max
8192
[root@brinquedo /root]# echo 20000 > /proc/sys/fs/file-max
[root@brinquedo /root]# ./max_sockets
nr_sockets=16381

- Arnaldo
