Return-Path: <linux-kernel-owner+w=401wt.eu-S1753598AbXAAJQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbXAAJQH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 04:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753604AbXAAJQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 04:16:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:32206 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbXAAJQD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 04:16:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IAW0vWwy9TQC/rv0tLhCKeL8NT0DhsJTZ+AK0CHkiavqjHcof8R/adGXU3gHHZ3FrItmu7PDG9dQNAn57Pl0fzO3SO9uYXXa5seKQpEq/26CaDdi+nhER15aQbqOk9QK+dI8q97NDd+pjppcY5DHD97QZ0hDs299ib6j3FnL9/g=
Message-ID: <80ec54e90701010116u27d02341kb2be785f17f18e3d@mail.gmail.com>
Date: Mon, 1 Jan 2007 10:16:02 +0100
From: "=?ISO-8859-1?Q?Daniel_Marjam=E4ki?=" <daniel.marjamaki@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net/core/flow.c: compare data with memcmp
Cc: netdev@vger.kernel.org, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <80ec54e90612312347w2b906e5eg725a7761110c6897@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <80ec54e90612310837y786fd764oc18bf37c8f0b2b8c@mail.gmail.com>
	 <20061231.123715.115911390.davem@davemloft.net>
	 <80ec54e90612312347w2b906e5eg725a7761110c6897@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have done a little testing on my own. My results is that memcpy is
many times faster even with aligned data.

I am testing in an ordinary console program. I am including the code below.
If I'm doing something wrong, please tell me so.

As you can see I am not using the same datadeclarations as the kernel
but I'm testing the algorithm here not the data. By testing various
data and types of data I can make sure the algorithm behaves correctly
in all situations.
The datamember 'd' in flowi is not part of the comparison, but by
changing it into an 'unsigned int' it becomes part of the comparison.



const int NUM_REP = 0x7FFFFFFF;

typedef unsigned int flow_compare_t;

struct flowi {
	unsigned int a,b,c;
	unsigned char d;
};


/* I hear what you're saying, use memcmp.  But memcmp cannot make
 * important assumptions that we can here, such as alignment and
 * constant size.
 */
static int flow_key_compare(struct flowi *key1, struct flowi *key2)
{
	flow_compare_t *k1, *k1_lim, *k2;
	const int n_elem = sizeof(struct flowi) / sizeof(flow_compare_t);

	k1 = (flow_compare_t *) key1;
	k1_lim = k1 + n_elem;

	k2 = (flow_compare_t *) key2;

	do {
		if (*k1++ != *k2++)
			return 1;
	} while (k1 < k1_lim);

	return 0;
}



static int flow_key_compare2(struct flowi *key1, struct flowi *key2)
{
	return memcmp(key1, key2, (sizeof(struct flowi) /
sizeof(flow_compare_t)) * sizeof(flow_compare_t));
}






int main()
{

	struct flowi key1 = {0,1,2,3};
	struct flowi key2 = {0,1,2,0};
	char str[300];
	int i;

	/* put data in aligned addresses */
	struct flowi *k1 = (struct flowi *)((int)(&str[100]) & 0xFFFFFFF0);
	struct flowi *k2 = (struct flowi *)((int)(&str[200]) & 0xFFFFFFF0);
	memcpy(k1, &key1, sizeof(struct flowi));
	memcpy(k2, &key2, sizeof(struct flowi));

	/* Compare data */
	printf("compare1..\n");
	for (i = 0; i < NUM_REP; i++)
		flow_key_compare(k1, k2);

	printf("compare2..\n");
	for (i = 0; i < NUM_REP; i++)
		flow_key_compare2(k1, k2);

	printf((flow_key_compare(k1,k2)==(flow_key_compare2(k1,k2)?1:0))?"ok\n":"error\n");

	return 0;
}











2007/1/1, Daniel Marjamäki <daniel.marjamaki@gmail.com>:
> Hello!
>
> So you mean that in this particular case it's faster with a handcoded
> comparison than memcmp? Because both key1 and key2 are located at
> word-aligned addresses?
> That's fascinating.
>
> Best regards,
> Daniel
>
> 2006/12/31, David Miller <davem@davemloft.net>:
> > From: "Daniel_Marjamäki" <daniel.marjamaki@gmail.com>
> > Date: Sun, 31 Dec 2006 17:37:05 +0100
> >
> > > From: Daniel Marjamäki
> > > This has been tested by me.
> > > Signed-off-by: Daniel Marjamäki <daniel.marjamaki@gmail.com>
> >
> > Please do not do this.
> >
> > memcmp() cannot assume the alignment of the source and
> > destination buffers and thus will run more slowly than
> > that open-coded comparison.
> >
> > That code was done like that on purpose because it is
> > one of the most critical paths in the networking flow
> > cache lookup which runs for every IPSEC packet going
> > throught the system.
> >
>
