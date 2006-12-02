Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163051AbWLBQPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163051AbWLBQPk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 11:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163054AbWLBQPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 11:15:40 -0500
Received: from master.altlinux.org ([62.118.250.235]:64520 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1163051AbWLBQPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 11:15:40 -0500
Date: Sat, 2 Dec 2006 19:15:19 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, Eric Piel <eric.piel@altlinux.org>,
       Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
Message-Id: <20061202191519.a25282ad.vsu@altlinux.ru>
In-Reply-To: <1165055432.3233.151.camel@laptopd505.fenrus.org>
References: <1164998179.5257.953.camel@gullible>
	<1165055432.3233.151.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; x86_64-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__2_Dec_2006_19_15_19_+0300_lE1R.jKwEATU1wi0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__2_Dec_2006_19_15_19_+0300_lE1R.jKwEATU1wi0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 02 Dec 2006 11:30:32 +0100 Arjan van de Ven wrote:

> On Fri, 2006-12-01 at 13:36 -0500, Ben Collins wrote:
> > I'd be willing to bet that most distros have this patch in their kernel.
> > One of those things we can't really live without.
> >
> > What I haven't understood is why it isn't included in the mainline
> > kernel yet.
>
> it's not that hard ;)
>
> replacing the DSDT code *while it's live* is just a bad idea.

But the suggested patch does not do this.

> The kernel already has a facility to override the DSDT, but that one
> does it *from the start*. Sounds like that one should be used or
> maybe enhanced a little to make it more distro friendly if something
> is lacking.

The patch replaces the DSDT with the binary from initramfs in the same
acpi_os_table_override() function as the currently available
CONFIG_ACPI_CUSTOM_DSDT does:

@@ -226,13 +291,20 @@ acpi_os_table_override(struct acpi_table
 	if (!existing_table || !new_table)
 		return AE_BAD_PARAMETER;

+	*new_table = NULL;
+
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
 	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
 		*new_table = (struct acpi_table_header *)AmlCode;
-	else
-		*new_table = NULL;
-#else
-	*new_table = NULL;
+#endif
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+	if (strncmp(existing_table->signature, "DSDT", 4) == 0) {
+		struct acpi_table_header* initrd_table = acpi_find_dsdt_initrd();
+		if (initrd_table) {
+			*new_table = initrd_table;
+			acpi_must_unregister_table = TRUE;
+		}
+	}
 #endif
 	return AE_OK;
 }

However, this patch slightly changes initialization order of some
kernel parts:

 - The call to populate_rootfs() is moved before calls to
   smp_prepare_cpus(max_cpus), do_pre_smp_initcalls(), smp_init(),
   sched_init_smp() and cpuset_init_smp().

 - The call to acpi_early_init() is moved from start_kernel() (where
   it is done just before rest_init()) to rest_init(), where it is now
   preceded by lock_kernel(), set_cpus_allowed(current, CPU_MASK_ALL),
   child_reaper = current and the moved populate_rootfs().

Not sure if this reordering is safe in theory, but it works for many
users of the patch.

--Signature=_Sat__2_Dec_2006_19_15_19_+0300_lE1R.jKwEATU1wi0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFcaaaW82GfkQfsqIRAvmOAJ9McibWx4ElgwoAtxzjmNxNRCiOugCghSY3
IsOoG5GiWuaz7s3pDKdXqvQ=
=jbbE
-----END PGP SIGNATURE-----

--Signature=_Sat__2_Dec_2006_19_15_19_+0300_lE1R.jKwEATU1wi0--
