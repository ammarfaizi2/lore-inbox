Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266869AbRGFWCf>; Fri, 6 Jul 2001 18:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266870AbRGFWCe>; Fri, 6 Jul 2001 18:02:34 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17164 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266869AbRGFWCY>; Fri, 6 Jul 2001 18:02:24 -0400
Date: Fri, 6 Jul 2001 19:02:28 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Neil Booth <neil@daikokuya.demon.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
Message-ID: <20010706190228.C4521@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Neil Booth <neil@daikokuya.demon.co.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Davide Libenzi <davidel@xmailserver.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15II3b-0003T8-00@the-village.bc.nu> <20010706183804.A13869@daikokuya.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010706183804.A13869@daikokuya.demon.co.uk>; from neil@daikokuya.demon.co.uk on Fri, Jul 06, 2001 at 06:38:04PM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 06, 2001 at 06:38:04PM +0100, Neil Booth escreveu:
> Alan Cox wrote:-
> 
> > #define min(a,b) __magic_minfoo(a,b, __var##__LINE__, __var2##__LINE__)
> > 
> > #define __magic_minfoo(A,B,C,D) \
> > 	{ typeof(A) C = (A)  .... }
> 
> No, that's buggy.  You need an extra level of indirection to expand
> __LINE__.  Arguments to ## are inserted in-place without expansion.

yes, so lets try with another indirection and see if I'm missing something
that you could clarify :)

[acme@brinquedo __attribute__]$ cat b.c
#define _min(a,b,line) __magic_minfoo(a,b, __var##line, __var2##line)
#define min(a,b) _min(a,b,__LINE__)

#define __magic_minfoo(A,B,C,D) \
       ({ typeof(A) C = (A); typeof(B) D = (B); C>D?D:C; })

void main(void)
{
      int __var11=5, __var211=7;

      printf("min(%d,%d) = %d (should be 11: %d)\n", __var11, __var211,
             min(__var11, __var211), __LINE__);
}
[acme@brinquedo __attribute__]$ cpp < b.c
# 1 ""
void main(void)
{
      int __var11=5, __var211=7;

      printf("min(%d,%d) = %d (should be 11: %d)\n", __var11, __var211,
             ({ typeof(   __var11   )   __var__LINE__   = (   __var11   );
typeof(    __var211   )   __var2__LINE__   = (    __var211   );
__var__LINE__  >  __var2__LINE__  ?  __var2__LINE__  :  __var__LINE__  ; })
, 12);
}
[acme@brinquedo __attribute__]$

- Arnaldo
