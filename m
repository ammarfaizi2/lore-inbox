Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268097AbUJMAMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268097AbUJMAMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 20:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUJMAMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 20:12:23 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:49816 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S268097AbUJMAMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 20:12:17 -0400
Subject: Re: Fw: signed kernel modules?
From: "Rusty Russell (IBM)" <rusty@au1.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Howells <dhowells@redhat.com>, rusty@ozlabs.au.ibm.com,
       Greg KH <greg@kroah.com>, Arjan van de Ven <arjanv@redhat.com>,
       Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097570159.5788.1089.camel@baythorne.infradead.org>
References: <1096544201.8043.816.camel@localhost.localdomain>
	 <1096411448.3230.22.camel@localhost.localdomain>
	 <1092403984.29463.11.camel@bach> <1092369784.25194.225.camel@bach>
	 <20040812092029.GA30255@devserv.devel.redhat.com>
	 <20040811211719.GD21894@kroah.com>
	 <OF4B7132F5.8BE9D947-ON87256EEB.007192D0-86256EEB.00740B23@us.ibm.com>
	 <1092097278.20335.51.camel@bach> <20040810002741.GA7764@kroah.com>
	 <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com>
	 <30797.1092308768@redhat.com>
	 <20040812111853.GB25950@devserv.devel.redhat.com>
	 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
	 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
	 <10345.1097507482@redhat.com>
	 <1097507755.318.332.camel@hades.cambridge.redhat.com>
	 <1097534090.16153.7.camel@localhost.localdomain>
	 <1097570159.5788.1089.camel@baythorne.infradead.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1097626296.4013.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 10:11:36 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 18:35, David Woodhouse wrote:
> We know _precisely_ what the kernel looks at -- we wrote its linker. It
> really isn't that hard.

Write the code.  Then come back and tell me it "isn't that hard".

Let me make this clear: I refuse to include any solution which doesn't
protect against accidental, as well as deliberate, corruption.  This
means your "canonicalization" code has to be very, very paranoid about
not trusting the data until the signature is verified.  The current code
does very simple checks then completely trusts the module contents,
especially the section headers: to make signatures worth anything, your
code must not do this.

Here's the level of paranoia required for the simplest case, that of
signing the entire module.  The last Howells patches I saw didn't even
do any of *this*, let alone checking the rest of the module:

+static int in_range(Elf_Ehdr *hdr,
+		    unsigned long len,
+		    unsigned long offset,
+		    unsigned long elemsize,
+		    unsigned long num)
+{
+	/* We're careful with wrap here. */
+	if (offset > len)
+		return 0;
+	if (elemsize * num / num != elemsize)
+		return 0;
+	if (elemsize * num > len - offset)
+		return 0;
+	return 1;
+}
+
+/* Lots of checking: we don't trust anything until signature matched. */
+static int check_modsig(Elf_Ehdr *hdr, unsigned long len)
+{
+	Elf_Shdr *sechdrs;
+	unsigned long i, stroff;
+
+	/* Section headers must all be in range. */
+	if (!in_range(hdr, len, hdr->e_shoff, sizeof(Elf_Shdr), hdr->e_shnum))
+		return -EINVAL;
+
+	/* Index of section which contains headers must be good. */
+	if (hdr->e_shstrndx >= hdr->e_shnum)
+		return -EINVAL;
+
+	sechdrs = (void *)hdr + hdr->e_shoff;
+	stroff = sechdrs[hdr->e_shstrndx].sh_offset;
+
+	for (i = 1; i < hdr->e_shnum; i++) {
+		if (!in_range(hdr, len, stroff+sechdrs[i].sh_name, 1,
+			      sizeof("module_sig")))
+			continue;
+		if (strcmp((char *)hdr + stroff+sechdrs[i].sh_name,
+			   "module_sig") != 0)
+			continue;
+		if (!in_range(hdr, len, sechdrs[i].sh_offset,
+			      sechdrs[i].sh_size, 1))
+			return -EINVAL;
+		return calc_signature(hdr, len, sechdrs[i].sh_offset,
+				      sechdrs[i].sh_size);
+	}
+	tainted |= TAINT_FORCED_MODULE;
+	return 0;
+}
+#else
+static int check_modsig(Elf_Ehdr *hdr, unsigned int len)
+{
+	return 0;
+}
+#endif /* CONFIG_MODULE_SIG */
+
 #ifdef CONFIG_SMP
 /* Number of blocks used and allocated. */
 static unsigned int pcpu_num_used, pcpu_num_allocated;
@@ -1522,6 +1614,9 @@ static struct module *load_module(void _
 	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr))
 		goto truncated;
 
+	if ((err = check_modsig(hdr, len)) != 0)
+		goto free_hdr;
+
 	/* Convenience variables */
 	sechdrs = (void *)hdr + hdr->e_shoff;
 	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;

> > Nor do I have to re-iterate the points from the discussion for someone
> > who hasn't bothered reading it.  But I did.
> 
> Sorry, I didn't think the discussion had been in public. While I'm sure
> I _could_ read mail in David's inbox, I feel it would be somewhat
> impolite. It's not that I "haven't bothered". :)

Sorry, thought you were CC'd the whole time.  My mistake.

Rusty.


